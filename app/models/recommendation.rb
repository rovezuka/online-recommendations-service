class Recommendation < ApplicationRecord
  # Атрибуты рекомендации
  validates :text, presence: true

  # Связь с запросом на консультацию
  belongs_to :consultation_request
end
