class User < ActiveRecord::Base
  acts_as_authentic
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.password_reset_instructions(self).deliver
  end
  
  def deliver_verification_instructions!
    reset_perishable_token!
    Notifier.account_verification_instructions(self).deliver
  end
  
  def verify!
    self.verified = true
    self.save
  end
end
