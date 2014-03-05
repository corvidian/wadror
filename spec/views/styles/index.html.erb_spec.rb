require 'spec_helper'

describe "styles/index" do
  before(:each) do
    assign(:styles, [
      stub_model(Style,
        :name => "Name",
        :description => "MyText"
      ),
      stub_model(Style,
        :name => "Name",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of styles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "ul>li", :text => "Name".to_s, :count => 2
  end
end
