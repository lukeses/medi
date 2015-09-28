class Visit < ActiveRecord::Base



  belongs_to :patient
  belongs_to :doctor
  belongs_to :clinic

  validates_datetime :start, :after => lambda { DateTime.now },
                               :before_message => "must be later than now"
  validates :clinic, presence: true
  validates :doctor_id, presence: true
  validate :check_work
  validate :check_workhour
  validate :check_visit

  def check_work
    if doctor.id.nil? || clinic.id.nil? || !Work.exists?(doctor_id: doctor.id, clinic_id: clinic.id)
      errors.add(:base, "not exist selected work")
    end
  end

  def check_workhour
    work = Work.find_by(doctor_id: doctor.id, clinic_id: clinic.id)
    if work.nil? || !Workhour.exists?(work_id: work.id, weekday: start.wday)
      errors.add(:base, "Doctor does not work in this hours")
    end
  end

  def check_visit
    if doctor.id.nil? || Visit.exists?(doctor_id: doctor.id, start: start, finish: finish)
      errors.add(:base, "Someone reservered this visit earlier")
      errors.add(:base, Visit.where(doctor_id: doctor.id, start: start, finish: finish).inspect)
    end
  end

  # def destroy_unconfirmed_visits
  #   Visit.connection
  #   Visit.delete_all(confirmed: false, created_at: DateTime.now-10.minutes)
  # end

end
