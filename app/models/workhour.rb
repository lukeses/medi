class Workhour < ActiveRecord::Base
  belongs_to :work

  after_create :create_possible_visits

  validate :check_other_workhours

  

  def create_possible_visits
    half_hour_step = (1.to_f/24/2)
    date_time = (DateTime.now+1.hour).beginning_of_hour.utc
    date_time_limit = (DateTime.now + 30.days).utc

    date_time.step(date_time_limit, 1.to_f) do |possible_date|
      if possible_date.wday == weekday
        puts possible_date
        start.to_datetime.step(finish.to_datetime-30.minutes, half_hour_step) do |possible_hour|
          visit = Visit.new
          visit.clinic = work.clinic
          visit.doctor = work.doctor
          visit.confirmed = false
          visit.start = possible_date.change(hour: possible_hour.hour, min: possible_hour.min)
          visit.finish = visit.start+30.minutes
          visit.save
        end
      end
    end
  end


  def check_other_workhours
    if (Workhour.where(weekday: weekday, start: start..finish).count + Workhour.where(weekday: weekday, finish: start..finish).count) > 0
      errors.add(:workhour, "1. Workhour between other workhours")
    elsif !Workhour.where(weekday: weekday).where(['start < ?', start]).order(:start).reverse.first.nil? &&  !Workhour.where(weekday: weekday).where(['finish > ?', finish]).order(:finish).first.nil? && Workhour.where(weekday: weekday).where(['start < ?', start]).order(:start).reverse.first.id == Workhour.where(weekday: weekday).where(['finish > ?', finish]).order(:finish).first.id
      errors.add(:workhour, "2. Workhour between other workhours")
    else
      workhours_to_check = Workhour.where(weekday: weekday).each do |workhour|
        if start < workhour.start
          validates_time :start, :before => lambda{ workhour.start }
          validates_time :finish, :on_or_before => lambda{ workhour.start }
        end
      end
    end
  end

end
