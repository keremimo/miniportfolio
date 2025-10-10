import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";
import { Dutch } from "flatpickr/dist/l10n/nl.js";

export default class extends Controller {
  static targets = ["input"];

  connect() {
    this.openOnFocus = this.openOnFocus.bind(this);

    this.picker = flatpickr(this.inputTarget, {
      dateFormat: "Y-m-d",
      altInput: true,
      altFormat: "d/m/Y",
      allowInput: true,
      altInputClass: "post-form__input",
      locale: Dutch,
      defaultDate: this.inputTarget.value || null,
      clickOpens: true,
      position: "auto", // let flatpickr decide best position
      wrap: false
    });

    if (this.picker?.altInput) {
      this.picker.altInput.addEventListener("focus", this.openOnFocus);
      this.picker.altInput.addEventListener("click", this.openOnFocus);
    }
  }

  disconnect() {
    if (this.picker?.altInput) {
      this.picker.altInput.removeEventListener("focus", this.openOnFocus);
      this.picker.altInput.removeEventListener("click", this.openOnFocus);
    }

    if (this.picker) {
      this.picker.destroy();
      this.picker = null;
    }
  }

  openOnFocus() {
    if (this.picker) {
      this.picker.open();
    }
  }
}
