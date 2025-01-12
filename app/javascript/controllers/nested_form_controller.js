import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["container", "template"];

  add(event) {
    event.preventDefault();
    console.log("Add button clicked!");

    const template = this.templateTarget
      ? this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
      : null;

    if (template) {
      this.containerTarget.insertAdjacentHTML("beforeend", template);
    } else {
      console.error("Template not found");
    }
  }

  remove(event) {
    event.preventDefault();
    const field = event.target.closest(".nested-fields");
    field.querySelector("input[name*='_destroy']").value = "1";
    field.style.display = "none";
  }
}
