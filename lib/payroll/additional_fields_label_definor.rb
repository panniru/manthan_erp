module Payroll
  module AdditionalFieldsLabelDefinor
  
    def self.included(base)
      p "extending------------"
      base.extend(ClassMethods)
    end
    
    module ClassMethods
    end
  end
    
end
