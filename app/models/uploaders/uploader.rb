require 'roo'
module Uploader
  attr_accessor :file

  def  initialize(file)
    self.file = file
  end

  def import
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      yield row
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
    instruments = import do |row|
      yield row
    end
    ActiveRecord::Base.transaction do
      if save_instruments(instruments)
        true
      else
        raise ActiveRecord::Rollback
        false
      end
    end
  end
  def save_instruments(instruments)
    if instruments.map(&:valid?).all?
      instruments.each(&:save!)
      true
    else
      instruments.each.with_index do |instrument, index|
        instrument.errors.full_messages.each do |message|
          errors.add :base, "#{file.original_filename} : Row #{index+2} : #{message}"
        end
      end
      false
    end
  end
end
