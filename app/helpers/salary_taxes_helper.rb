module SalaryTaxesHelper

  def instruments_in_json(instruments)
    instruments.map{|ins| ins.attributes.to_json}
  end
end
