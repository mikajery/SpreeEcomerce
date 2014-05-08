Deface::Override.new(:virtual_path => 'spree/admin/users/_form',
  :name => 'add_client_to_user',
  :insert_after => "erb[loud]:contains('div.omega:last')",
  :text => "
    <div class='omega six columns'>
    <%= f.field_container :client_id do %>
      <%= f.label :client_id, raw(Spree.t(:client_id) + content_tag(:span, ' *')) %>
      <%= f.text_field :client_id, :value => '') %>
      <%= f.error_message_on :client_id %>
    <% end %>
    </div>
  ")
  