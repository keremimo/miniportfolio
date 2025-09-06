// Vite entrypoint for Rails
import "@hotwired/turbo-rails";

// Stimulus controllers via vite-plugin-ruby helper
import { Application } from "@hotwired/stimulus";
import { registerControllers } from "vite-plugin-ruby/register-controllers";

const application = Application.start();
registerControllers(application);

// ActionText / Trix
import "trix";
import "@rails/actiontext";

// Global styles
import "../stylesheets/application.css";
