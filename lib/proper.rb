require 'rubygems'
require 'sass'

def get_file_as_string(file_name)
  out = ""
  File.open(file_name, "r") do |infile|
    while (line = infile.gets)
      out << line
    end
  end
  out
end

test_css = get_file_as_string('test.css')
root_node = Sass::SCSS::Parser.new(test_css).parse

properties = {}

root_node.children.select{|n| n.class == Sass::Tree::RuleNode}.each do |node|
  puts " --> start"
  puts node.rule
  puts " --> end"
  node.children.each do |child_node|
    puts child_node.class
  end
end
 
