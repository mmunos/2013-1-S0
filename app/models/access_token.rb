class AccessToken < ActiveRecord::Base
  belongs_to :user

  before_create :generate

  private 

  def generate
    begin
      self.token = SecureRandom.hex
    end while self.class.exists?(token: token)
  end
  
end
