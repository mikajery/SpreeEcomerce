Deface::Override.new(
                     :virtual_path => 'spree/layouts/admin',
                     :name => 'custom-admin-tab',
                     :replace => "nav#admin-menu",
                     :text => '<h1>This is the new NAV</h1>'
                    )