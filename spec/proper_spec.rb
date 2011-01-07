require 'spec_helper'

describe Proper::Proper do

  before do
    @proper = Proper::Proper.new
  end

  it "has a prop_hash" do
    @proper.prop_hash.should be_kind_of Hash
  end

  describe "load_prop_hash" do

    context "given an array of rules" do

      it "loads the prop_hash with props as keys" do
        rules = @proper.extract_rules('test.css')
        @proper.load_prop_hash(rules)
        @proper.prop_hash["background-color:green"].should == [".style_one", ".style_three", ".style_two"]
      end

    end

  end

  describe "extract_rules" do

    context "given the path to a file" do

      before do
        @rules = @proper.extract_rules('test.css')
      end

      it "should return all rules" do
        @rules.size.should == 2
      end

      it "should return rules" do
        @rules.each do |rule|
          rule.should be_kind_of Sass::Tree::RuleNode
        end
      end

    end

  end

  describe "props_for_node" do

    before do
      @node = @proper.extract_rules('test.css').first
      @props = @proper.props_for_node(@node)
    end

    it "should return props" do
      @props.length.should > 0
    end

    it "should return only prop nodes" do
      @props.each do |prop|
        prop.should be_kind_of Sass::Tree::PropNode
      end
    end

  end

end