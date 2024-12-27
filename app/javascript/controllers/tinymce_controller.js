import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    const apiKey = document.querySelector('meta[name="tinymce-api-key"]').content;
    const script = document.createElement("script");
    script.src = `https://cdn.tiny.cloud/1/${apiKey}/tinymce/6/tinymce.min.js`;
    script.referrerPolicy = "origin";
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
