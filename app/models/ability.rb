class Ability
  include CanCan::Ability

  def initialize(user)
    return false if user == nil
    alias_action :month_wise_fee_of_student, :to => :read
    alias_action :monthly_pdc_amounts, :to => :read
    alias_action :all_grades, :to => :read
    alias_action :create_bulk, :to => :create
    alias_action :save_monthly_pdc_amounts, :to => :create
    alias_action :accrued_interest, :to => :update

    if user.admin?
      can :manage, :all
    elsif user.parent?
      can :manage, [MonthlyPdcAmount, ParentPaymentMaster, ParentPaymentTransaction, CommunicationMail]
      can :read, [GradeWiseFee, TermWiseGradeFee, MonthlyPdcAmount]
    elsif user.accountant?
      can :manage, [GradeWiseFee, TermWiseGradeFee, MonthlyPdcAmount, ParentPaymentMaster, ParentCheque, ParentPaymentTransaction, ApprovalItem]
      can :read, [JobRun, FeeReports]
    elsif user.principal?
      can :read, :all
    else
      can :manage, [CommunicationMail]
    end
  end
  
end
