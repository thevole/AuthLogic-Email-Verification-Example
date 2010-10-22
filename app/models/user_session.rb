class UserSession < Authlogic::Session::Base
  include ActiveModel::Conversion

      def persisted?
        false
      end
      
      validate :check_if_validated
      
      private
      
      def check_if_validated
        errors.add(:base, "You have not yet verified your account") unless attempted_record && attempted_record.verified
      end
    
end