class DropActivityMastersTable < ActiveRecord::Migration
  def change
  	drop_table :activity_masters
  end
end
