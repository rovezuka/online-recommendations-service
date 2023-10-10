require 'httparty'

class MedicalDataController < ApplicationController
  include HTTParty

  base_uri 'https://api.fda.gov'

  # POST /consultation_requests/:request_id/recommendations
  def create_recommendation
    consultation_request = ConsultationRequest.find(params[:request_id])

    # Выполняем запрос к OpenFDA API
    response = self.class.get('/drug/event.json', query: { search: 'aspirin', limit: 1 })

    if response.success?
      # Обработка успешного ответа
      data = JSON.parse(response.body)
      recommendation_text = data['results'][0]['patient']['drug'][0]['medicinalproduct']

      # Создаем рекомендацию
      recommendation = Recommendation.create(text: recommendation_text)

      # Привязываем рекомендацию к запросу на консультацию
      consultation_request.recommendation = recommendation

      if consultation_request.save
        render json: recommendation, status: :created
      else
        render json: consultation_request.errors, status: :unprocessable_entity
      end
    else
      # Обработка ошибки
      render json: { error: 'Ошибка при получении данных из OpenFDA' }, status: :unprocessable_entity
    end
  end

  # GET /patients/:patient_id/recommendations
  def patient_recommendations
    patient = Patient.find(params[:patient_id])
    recommendations = patient.consultation_requests.includes(:recommendation).map(&:recommendation)

    render json: recommendations
  end
end
