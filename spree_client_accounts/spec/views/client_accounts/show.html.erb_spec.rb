require 'spec_helper'

describe "client_accounts/show" do
  before(:each) do
    @client_account = assign(:client_account, stub_model(ClientAccount,
      :name => "Name",
      :credit_duration => 1,
      :credit_limit => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
