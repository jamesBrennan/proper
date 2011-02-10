module Proper
  class SassUtils

    def self.prop_as_string(prop_node)
      begin
        prop_node.name[0] << ":" << "#{prop_node.value}"
      rescue ArgumentError => e
        puts "argument error #{prop_node.value.inspect}"
        "error"
      end
    end

    def self.rule_names(rule_node)
      rule_node.rule.map { |r| r.gsub("\n", "").split(",") }.flatten
    end

  end
end

