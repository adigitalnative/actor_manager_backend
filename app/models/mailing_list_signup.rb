class MailingListSignup < ApplicationRecord
  validates :email, presence: true
end
