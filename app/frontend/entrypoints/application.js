// Vite entrypoint for Rails
import "@hotwired/turbo-rails"

// Stimulus controllers with HMR
import { Application } from "@hotwired/stimulus"
import { registerControllers } from "stimulus-vite-helpers"

const application = Application.start()
const controllers = import.meta.glob("../controllers/**/*_controller.js", { eager: true })
registerControllers(application, controllers)

// ActionText / Trix
import "trix"
import "@rails/actiontext"

// Global styles
import "../stylesheets/application.css"
