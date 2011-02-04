require 'spec_helper'

describe Proper::SassUtils do

  before do
    @utils = Proper::SassUtils
  end

  describe "prop_as_string" do

    context "given a Sass property node" do

      it "returns a string formatted 'name : value'" do
        prop_node = stub(:resolved_name => "background-color", :resolved_value => "green")
      end

    end

  end


end