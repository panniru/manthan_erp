# require 'roo'
# module Uploader
#   attr_accessor :file

#   def  initialize(file)
#     self.file = file
#   end

#   def import
#     spreadsheet = open_spreadsheet(file)
#     header = spreadsheet.row(1)
#     (2..spreadsheet.last_row).map do |i|
#       row = Hash[[header, spreadsheet.row(i)].transpose]
#       yield row
#     end
#   end

#   def open_spreadsheet(file)
#     case File.extname(file.original_filename)
#     when '.csv' then Roo::Csv.new(file.path, nil, :ignore)
#     when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
#     when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
#     else raise "Unknown file type: #{file.original_filename}"
#     end
#   end

#   def save
#     instruments = import do |row|
#       yield row
#     end
#     ActiveRecord::Base.transaction do
#       if save_instruments(instruments)
#         true
#       else
#         raise ActiveRecord::Rollback
#         false
#       end
#     end
#   end
#   def save_instruments(instruments)
#     if instruments.map(&:valid?).all?
#       instruments.each(&:save!)
#       true
#     else
#       instruments.each.with_index do |instrument, index|
#         instrument.errors.full_messages.each do |message|
#           errors.add :base, "#{file.original_filename} : Row #{index+2} : #{message}"
#         end
#       end
#       false
#     end
#   end
# end
require 'rubygems'       
require 'spreadsheet'
require 'roo'
module Uploader
  attr_accessor :file

  def  initialize(file)
    self.file = file
  end

  def import
    spreadsheet = open_spreadsheet(file)
    spreadsheet.each_with_pagename do |name, sheet|
      puts "Loading Sheet ######## #{name}"
      #Logger.info "Loading Sheet ######## #{name}"
      header = sheet.row(1).map(&:downcase)
      students = (2..sheet.last_row).map do |i|
        row = Hash[[header, sheet.row(i)].transpose]
        yield row
      end
      puts "Loading Sheet ######## #{name} Count: #{sheet.count}"
    end
  end

  def open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then Roo::Csv.new(file.path, nil, :ignore)
    when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
    when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def save
    status = false
    ActiveRecord::Base.transaction do
      begin
        spreadsheet = open_spreadsheet(file)
        spreadsheet.each_with_pagename do |name, sheet|
          puts "Loading Sheet ######## #{name}"
          #Logger.info "Loading Sheet ######## #{name}"
          header = sheet.row(1) #.map(&:downcase)
          models = (2..sheet.last_row).map do |i|
            row = Hash[[header, sheet.row(i)].transpose]
            yield row, :sheet_name => name
          end
          puts "Loaded Sheet ######## #{name} Count: #{sheet.count}"
          if save_records(name, models)
            status = true
            #RAILS.loger.info "##########All Sheets Uploaded"
          else
            status = false
            raise ActiveRecord::Rollback
            #RAILS.loger.fatal "###########Error in uploading Rolling back..."
          end
        end
      rescue Exception => e
        errors.add :base, "Error: #{e.message}"
        raise ActiveRecord::Rollback
      end
    end
  end

  def save_records(name , models)
    if models.map(&:valid?).all?
      models.each{|m| m.save!}
      true
    else
      models.each.with_index do |model, index|
        model.errors.full_messages.each do |message|
          errors.add :base, "File: #{file.original_filename}, Sheet: #{name},  Row: #{index+2} : #{message}"
        end
      end
      false
    end
  end
end
