class Work < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :clinic
  has_many :workhours
end
