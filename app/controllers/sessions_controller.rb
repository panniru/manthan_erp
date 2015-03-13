class SessionsController  < Devise::SessionsController

  def create
    super
    session[:transaction_date] = DayEnd.current_date #.prev_month
    financial_year_cal = Payroll::FinancialYearCalculator.new(session[:transaction_date])
    session[:financial_year_from] = financial_year_cal.financial_year_from
    session[:financial_year_to] = financial_year_cal.financial_year_to
    session[:financial_year] = financial_year_cal.financial_year
    session[:academic_year] = "2013-14"
  end

end
