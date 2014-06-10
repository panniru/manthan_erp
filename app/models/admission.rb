class Admission < ActiveRecord::Base
  validates :form_no, presence: true
end
