class Patient < ActiveRecord::Base
  has_many :visits, :dependent => :delete_all
  belongs_to :user
end
