Deface::Override.new(:virtual_path => "spree/shared/_main_nav_bar",
                     :name => "pages_in_header",
                     :insert_bottom => "#main-nav-bar",
                     :partial => "<h1> Test</h1>",
                     :disabled => true)