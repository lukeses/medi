class Work < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :clinic
end
