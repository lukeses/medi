class Work < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :clinic
  has_many :workhours

  validates :doctor, presence: true
  validates :clinic, presence: true

end
