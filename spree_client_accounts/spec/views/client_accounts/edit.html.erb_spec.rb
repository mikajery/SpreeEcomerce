require 'spec_helper'

describe "client_accounts/edit" do
  before(:each) do
    @client_account = assign(:client_account, stub_model(ClientAccount,
      :name => "MyString",
      :credit_duration => 1,
      :credit_limit => 1
    ))
  end

  it "renders the edit client_account form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", client_account_path(@client_account), "post" do
      assert_select "input#client_account_name[name=?]", "client_account[name]"
      assert_select "input#client_account_credit_duration[name=?]", "client_account[credit_duration]"
      assert_select "input#client_account_credit_limit[name=?]", "client_account[credit_limit]"
    end
  end
end
