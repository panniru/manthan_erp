class Book < ActiveRecord::Base
  has_many :damagebooks
  has_many :issuings
  #attr_accessible :name, :author
  # create_table :book do |t|
  #    t.column :name, :string
  #    t.column :author, :string
  #  end
end
