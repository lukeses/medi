class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # attr_accessor :pwz_number

before_destroy :destroy_doctor


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :patient, :dependent => :destroy
  has_one :doctor, :dependent => :delete
  has_one :admin

  validates :pesel, :pesel => true

accepts_nested_attributes_for :doctor


  def destroy_doctor
    doctor_to_delete = Doctor.find_by(user_id: id)
    doctor_to_delete.destroy unless doctor_to_delete.nil?
  end

  def admin?
    self.admin.nil? ? false : true
  end

  def doctor?
    self.doctor.nil? ? false : true
  end

  def patient?
    self.patient.nil? ? false : true
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
