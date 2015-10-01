class Doctor < ActiveRecord::Base
  has_many :visits
  belongs_to :user
  has_many :works

  validate :pwz_check

  def pwz_check
    pwz_array = Array.new
    pwz.to_s.each_char do |char|
      pwz_array << char.to_i
    end
    sum = 0
    arr = Array(1..6)
    pwz_array[1..6].zip(arr) do |pwz_num, wage|
      puts pwz_num
      puts wage
      puts sum
      sum = sum + pwz_num*wage
    end
    if (sum % 11) == pwz_array[0]
      true
    else
      false
    end
  end

end
