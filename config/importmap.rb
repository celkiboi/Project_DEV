# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "@hotwired--turbo-rails.js" # @8.0.12
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "comments", to: "comments.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "tinymce", to: "/assets/tinymce/tinymce.min.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "tailwind", to: "tailwind.css"

pin "@hotwired/turbo", to: "@hotwired--turbo.js" # @8.0.12
pin "@rails/actioncable/src", to: "@rails--actioncable--src.js" # @7.2.201
