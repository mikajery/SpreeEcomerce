require 'spec_helper'

describe "client_accounts/index" do
  before(:each) do
    assign(:client_accounts, [
      stub_model(ClientAccount,
        :name => "Name",
        :credit_duration => 1,
        :credit_limit => 2
      ),
      stub_model(ClientAccount,
        :name => "Name",
        :credit_duration => 1,
        :credit_limit => 2
      )
    ])
  end

  it "renders a list of client_accounts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
