class ConsultationRequest < ApplicationRecord
  # Атрибуты запроса на консультацию
  validates :text, presence: true
  validates :created_at, presence: true

  # Связь с пациентом
  belongs_to :patient

  # Связь с рекомендацией
  has_many :recommendations, dependent: :destroy
end
