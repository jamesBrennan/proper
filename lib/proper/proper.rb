module Proper

  class Proper

    attr_reader :prop_hash

    def initialize
      puts "initialized"
      @prop_hash = Hash.new
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
      rules.each do |rule_node|
        props_for_node(rule_node).each do |prop|
          key = prop_key(prop)
          if @prop_hash[key]
            @prop_hash[key] = @prop_hash[key] + rule_names(rule_node)
          else
            @prop_hash[key] = rule_names(rule_node)
          end
        end
      end
    end

    def write_to_file(path)
      File.open(path, "w") do |f|
        sorted_props = @prop_hash.keys.sort
        sorted_props.each do |prop|
          f.puts "/* #{prop.split(":").join(": ")} */"
          f.puts @prop_hash[prop].join(",") + "{#{prop};}"
          f.puts " "

          puts "/* #{prop.split(":").join(": ")} */"
          puts @prop_hash[prop].join(",") + "{#{prop};}"
          puts " "

        end
      end
    end

    private


    def get_file_as_string(file_name)
      out = ""
      File.open(file_name, "r") do |infile|
        while (line = infile.gets)
          out << line
        end
      end
      out
    end

    def prop_key(prop_node)
      prop_node.name.to_s << ":" << prop_node.value.to_s
    end

    def rule_names(rule_node)
      rule_node.rule.map { |r| r.gsub("\n", "").split(",") }.flatten
    end

  end


end