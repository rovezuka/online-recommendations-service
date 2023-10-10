Rails.application.routes.draw do
  # Ресурсы для пациентов (CRUD операции)
  resources :patients, only: [:create]

  # Ресурсы для запросов на консультацию (CRUD операции)
  resources :consultation_requests, only: [:create]

  # Ресурсы для рекомендаций (CRUD операции)
  resources :recommendations, only: [:create]

  # Маршруты для анализа медицинских данных
  post '/consultation_requests', to: 'consultation_requests#create' # Создание запроса на консультацию
  post '/consultation_requests/:request_id/recommendations', to: 'medical_data#create_recommendation' # Создание рекомендации для конкретного запроса на консультацию
  get '/patients/:patient_id/recommendations', to: 'medical_data#patient_recommendations' # Получение списка рекомендаций для конкретного пациента
end
