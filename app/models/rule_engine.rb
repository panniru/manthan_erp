class RuleEngine
  def value(context, rule_name)
    rule = RULE_SETUPS.fetch(context.to_s) { {} }
    rule.fetch(rule_name.to_s) { }
  end
end
