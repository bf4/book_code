require 'deadweight'

Deadweight::RakeTask.new do |dw|
  dw.stylesheets = ["/assets/application.css",
                    "/assets/normalize.css",
                    "/assets/layout.css",
                    "/assets/sidebar.css",
                    "/assets/navigation.css",
                    "/assets/notifications.css",
                    "/assets/creations.css"]
  dw.pages = ["/creations/index",
              "/creations/1"]
end
