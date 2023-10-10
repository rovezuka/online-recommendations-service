class RecommendationsController < ApplicationController
        # Действие для создания новой рекомендации
        def create
          recommendation = Recommendation.new(recommendation_params)
          if recommendation.save
            render json: recommendation, status: :created
          else
            render json: recommendation.errors, status: :unprocessable_entity
          end
        end
      
        private
      
        def recommendation_params
          params.require(:recommendation).permit(:text, :consultation_request_id)
        end
end
      