# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "tinymce", to: "https://cdn.jsdelivr.net/npm/tinymce@6/tinymce.min.js"
pin_all_from "app/javascript/controllers", under: "controllers"
