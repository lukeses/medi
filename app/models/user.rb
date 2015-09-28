class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # attr_accessor :pwz_number




  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :patient, :dependent => :destroy
  has_one :doctor, :dependent => :destroy
  has_one :admin

  validates :pesel, :pesel => true

accepts_nested_attributes_for :doctor


  def admin?
    self.admin.nil? ? false : true
  end

  def active_for_authentication? 
    super && approved? 
  end 

  def inactive_message 
    if !approved? 
      :not_approved 
    else 
      super # Use whatever other message 
    end 
  end

end
