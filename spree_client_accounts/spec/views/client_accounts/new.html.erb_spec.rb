require 'spec_helper'

describe "client_accounts/new" do
  before(:each) do
    assign(:client_account, stub_model(ClientAccount,
      :name => "MyString",
      :credit_duration => 1,
      :credit_limit => 1
    ).as_new_record)
  end

  it "renders new client_account form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", client_accounts_path, "post" do
      assert_select "input#client_account_name[name=?]", "client_account[name]"
      assert_select "input#client_account_credit_duration[name=?]", "client_account[credit_duration]"
      assert_select "input#client_account_credit_limit[name=?]", "client_account[credit_limit]"
    end
  end
end
