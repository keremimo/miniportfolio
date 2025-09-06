import { Controller } from "@hotwired/stimulus";

// Stimulus controller that turns a CSS Grid into a masonry layout
// with left-to-right visual order by computing row spans.
export default class extends Controller {
  static values = {
    rowHeight: { type: Number, default: 4 }, // px per auto row (finer granularity)
  };

  connect() {
    // Set a CSS variable so CSS can switch grid-auto-rows from auto → fixed
    this.element.style.setProperty("--masonry-auto-rows", `${this.rowHeightValue}px`);

    this._layout = this._raf(this.layout.bind(this));

    // Layout now and on resize
    this._layout();
    window.addEventListener("resize", this._layout);

    // Recalculate after each image loads (heights change)
    this._imageLoadHandler = () => this._layout();
    this._attachImageListeners();
  }

  disconnect() {
    window.removeEventListener("resize", this._layout);
    this._detachImageListeners();
  }

  layout() {
    const grid = this.element;
    const computed = getComputedStyle(grid);
    const rowGap = parseFloat(computed.rowGap || computed.gridRowGap || 0);
    const rowHeight = this.rowHeightValue;

    // For each direct grid item, compute how many rows it should span
    const items = Array.from(grid.children);
    for (const item of items) {
      item.style.gridRowEnd = "auto"; // reset before measuring
      const contentHeight = item.getBoundingClientRect().height;
      const span = Math.max(1, Math.ceil((contentHeight + rowGap) / (rowHeight + rowGap)));
      item.style.gridRowEnd = `span ${span}`;
    }
  }

  _attachImageListeners() {
    const images = this.element.querySelectorAll("img");
    images.forEach((img) => {
      img.addEventListener("load", this._imageLoadHandler);
      // Some images might already be cached/loaded
      if (img.complete) {
        this._imageLoadHandler();
      }
    });
  }

  _detachImageListeners() {
    const images = this.element.querySelectorAll("img");
    images.forEach((img) => img.removeEventListener("load", this._imageLoadHandler));
  }

  _raf(fn) {
    let scheduled = false;
    return (...args) => {
      if (scheduled) return;
      scheduled = true;
      requestAnimationFrame(() => {
        scheduled = false;
        fn(...args);
      });
    };
  }
}
