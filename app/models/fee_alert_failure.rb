class FeeAlertFailure < ActiveRecord::Base
  belongs_to :parent
  belongs_to :job_run
end
