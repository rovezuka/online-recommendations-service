class ConsultationRequestsController < ApplicationController
        skip_before_action :verify_authenticity_token, only: [:create]

        # Действие для создания нового запроса на консультацию
        def create
          consultation_request = ConsultationRequest.new(consultation_request_params)
          if consultation_request.save
            render json: consultation_request, status: :created
          else
            render json: consultation_request.errors, status: :unprocessable_entity
          end
        end
      
        private
      
        def consultation_request_params
          params.require(:consultation_request).permit(:text, :created_at, :patient_id)
        end
end