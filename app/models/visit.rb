class Visit < ActiveRecord::Base
  belongs_to :patient
  belongs_to :doctor
  belongs_to :clinic
end
