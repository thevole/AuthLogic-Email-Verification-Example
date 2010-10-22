require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "password_reset_instructions" do
    mail = Notifier.password_reset_instructions
    assert_equal "Password reset instructions", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
