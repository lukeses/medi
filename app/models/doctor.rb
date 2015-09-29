class Doctor < ActiveRecord::Base
  has_many :visits
  belongs_to :user
  has_many :works

end
