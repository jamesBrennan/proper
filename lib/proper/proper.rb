require 'sass'

module Proper

  class Proper

    attr_accessor :stylesheets, :output, :log_file, :compact
    attr_reader :prop_hash

    def initialize
      @prop_hash = Hash.new
      @stylesheets = []
      @compact = true
      @output = ""
    end

    def run
      @stylesheets.each do |stylesheet|
        load_prop_hash(extract_rules(stylesheet))
      end
      write_to_file(@output)
    end

    def extract_rules(path)
      css_string = get_file_as_string(path)
      root_node  = Sass::SCSS::Parser.new(css_string).parse
      root_node.children.select { |n| n.class == Sass::Tree::RuleNode }
    end

    def props_for_node(rule_node)
      rule_node.children.select { |n| n.class == Sass::Tree::PropNode }
    end

    def load_prop_hash(rules)
      if rules
        rules.each do |rule_node|
          props_for_node(rule_node).each do |prop|
            key = SassUtils.prop_as_string(prop)
            if @prop_hash[key]
              @prop_hash[key] = @prop_hash[key] + SassUtils.rule_names(rule_node)
            else
              @prop_hash[key] = SassUtils.rule_names(rule_node)
            end
          end
        end
      end
    end

    def write_to_file(path)
      File.open(path, "w") do |f|
        sorted_props = @prop_hash.keys.sort
        sorted_props.each do |prop|
          f.puts "/* #{prop.split(":").join(": ")} */" unless @compact
          f.puts @prop_hash[prop].join(",") + "{#{prop};}"
          f.puts " " unless @compact
        end
      end
    end

    private

    def get_file_as_string(file_name)
      out = ""
      File.open(file_name, "r") do |infile|
        while (line = infile.gets)
          out << line.force_encoding("UTF-8")
        end
      end
      out
    end

  end


end