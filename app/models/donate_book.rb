class DonateBook < ActiveRecord::Base
  belongs_to :book
  accepts_nested_attributes_for :book
end
