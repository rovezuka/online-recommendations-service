class RecommendationsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  require 'net/http'
  require 'json'

  # POST /consultation_requests/:request_id/recommendations
  def create
    consultation_request = ConsultationRequest.find(params[:request_id])

    url = URI.parse('https://api.fda.gov/drug/event.json')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == 'https')
    request = Net::HTTP::Get.new(url.request_uri)
    response = http.request(request)

    if response.code == '200'
      data = JSON.parse(response.body)

      if data['results']
        recommendations = []

        # Извлекаем поле "drug" из каждой записи в JSON-ответе
        data['results'].each do |result|
          drugs = result['patient']['drug']

          # Перебираем массив с данными о лекарствах
          drugs.each do |drug|
            medicinalproduct = drug['medicinalproduct']
            drugindication = drug['drugindication']

            # Создаем рекомендацию на основе данных о лекарстве
            text = "Рекомендация на основе данных из OpenFDA: #{medicinalproduct}, #{drugindication}"
            recommendations << consultation_request.recommendations.new(text: text)
          end
        end

        if recommendations.empty?
          render json: { error: 'Нет данных для создания рекомендаций' }, status: :unprocessable_entity
        else
          Recommendation.transaction do
            recommendations.each(&:save)
          end

          render json: recommendations, status: :created
        end
      else
        render json: { error: 'Не удалось получить данные из API OpenFDA' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Ошибка при запросе к API OpenFDA' }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
