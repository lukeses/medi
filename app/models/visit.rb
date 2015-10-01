class Visit < ActiveRecord::Base

  belongs_to :patient
  belongs_to :doctor
  belongs_to :clinic

  validates_datetime :start, :after => lambda { DateTime.now },
                               :before_message => "must be later than now"
  validates :clinic, presence: true
  validates :doctor_id, presence: true

end
