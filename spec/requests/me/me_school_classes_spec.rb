require 'spec_helper'

describe "Me::SchoolClasses" do
  describe "GET /me_school_classes" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get me_school_classes_path
      response.status.should be(200)
    end
  end
end