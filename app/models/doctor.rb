class Doctor < ActiveRecord::Base
  has_many :visits
  belongs_to :user
end
