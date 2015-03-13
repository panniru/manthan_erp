module Payroll
  class FinancialYearCalculator
    
    def initialize(date)
      @date = date
    end

    def financial_year
      "#{financial_year_from.year}-#{financial_year_to.year}"
    end
    
    def remaining_months_in_the_fianancial_year
      fin_year_to = financial_year_to
      (fin_year_to.year * 12 + fin_year_to.month) - (@date.year * 12 + @date.month)
    end

    def financial_year_from
      if current_month > 3
        Date.new(current_year, 04, 1)
      else
        Date.new(current_year-1, 04, 1)
      end
    end

    def financial_year_to
      if current_month > 3
        Date.new(current_year+1, 03, 31)
      else
        Date.new(current_year, 03, 31)
      end
    end

    def quarter_1_range
      (financial_year_from.beginning_of_quarter..financial_year_from.end_of_quarter)
    end


    def quarter_2_range
      quarter_2 = quarter_1_range.first.next_quarter
      (quarter_2.beginning_of_quarter..quarter_2.end_of_quarter)
    end

    def quarter_3_range
      quarter_3 = quarter_2_range.first.next_quarter
      (quarter_3.beginning_of_quarter..quarter_3.end_of_quarter)
    end

    def quarter_4_range
      quarter_4 = quarter_3_range.first.next_quarter
      (quarter_4.beginning_of_quarter..quarter_4.end_of_quarter)
    end

    def current_quarter_num
      if [4, 5,6].include? @date.month
        1
      elsif [7,8,9].include? @date.month
        2
      elsif [10,11,12].include? @date.month
        3
      elsif [1,2,3].include? @date.month
        4
      end
    end

    def self.get_months_in_quarter(quarter)
      case quarter
      when 1
        [4,5,6]
      when 2
        [7,8,9]
      when 3
        [10,11,12]
        #[Date.new(@date.year, 10, 1), Date.new(@date.year, 11, 1), Date.new(@date.year, 12, 1)]
      when 4
        [1,2,3]
        #[Date.new(@date.year, 1, 1), Date.new(@date.year, 2, 1), Date.new(@date.year, 3, 1)]
      end
    end
    

    def self.get_month_dates_in_fin_year_quarter(quarter, financial_year)
      fin_year_from = financial_year.split("-")[0].to_i
      fin_year_to = financial_year.split("-")[1].to_i
      case quarter
      when 1
        [Date.new(fin_year_from, 4, 1), Date.new(fin_year_from, 5, 1), Date.new(fin_year_from, 6, 1)]
      when 2
        [Date.new(fin_year_from, 7, 1), Date.new(fin_year_from, 8, 1), Date.new(fin_year_from, 9, 1)]
      when 3
        [Date.new(fin_year_from, 10, 1), Date.new(fin_year_from, 11, 1), Date.new(fin_year_from, 12, 1)]
      when 4
        [Date.new(fin_year_to, 1, 1), Date.new(fin_year_to, 2, 1), Date.new(fin_year_to, 3, 1)]
      end
    end



    private
    
    def current_month
      @date.month
    end

    def current_year
      @date.year
    end
    
  end
end
