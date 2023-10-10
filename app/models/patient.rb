class Patient < ApplicationRecord
  # Атрибуты пациента
  validates :full_name, presence: true
  validates :date_of_birth, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  # Связь с запросами на консультацию
  has_many :consultation_requests, dependent: :destroy
end
