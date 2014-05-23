class AmountConversion
  
  def initialize
    @rule_engine = RuleEngine.new
  end
  
  def part_percentage_from_total_percentage(marfed_total_amt, amount_per)
    act_amt = marfed_total_amt * @rule_engine.value(:amount, :unit)
    ((amount_per/100) * act_amt).to_f/@rule_engine.value(:amount, :unit)
  end

  def defined_denomination_in_words
    amount = @rule_engine.value(:amount, :unit)
    case amount
      when 100
      "Hundreds"
      when 1000
      "Thousands"
      when 100000
      "lakhs"
    else
      "Rupees"
    end
  end


end
