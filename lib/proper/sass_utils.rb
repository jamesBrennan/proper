class Proper::SassUtils

  def self.prop_as_string(prop_node)
    prop_node.name.to_s << ":" << prop_node.value.to_s
  end

  def self.rule_names(rule_node)
    rule_node.rule.map { |r| r.gsub("\n", "").split(",") }.flatten
  end

end

