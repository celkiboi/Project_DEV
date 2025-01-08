import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    const script = document.createElement("script");
    script.src = "/assets/tinymce/tinymce.min.js";
    script.onload = () => this.initializeEditor();
    document.head.appendChild(script);
  }

  initializeEditor() {
    tinymce.init({
      target: this.element,
      language: 'hr',
      menubar: false,
      toolbar:
        "undo redo | bold italic | forecolor backcolor | alignleft aligncenter alignright alignjustify | bullist numlist | fontsizeselect",
      plugins: ["lists", "textcolor", "advlist"],
      height: 300,
      branding: false,
    });
  }

  disconnect() {
    if (typeof tinymce !== "undefined") {
      tinymce.remove(this.element);
    }
  }
}
