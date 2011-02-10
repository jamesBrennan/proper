module Proper
  class SassUtils

    def self.prop_as_string(prop_node)
      prop_node.name[0] << ":" << "#{prop_node.value}"
    end

    def self.rule_names(rule_node)
      rule_node.rule.map { |r| r.gsub("\n", "").split(",") }.flatten
    end

  end
end

