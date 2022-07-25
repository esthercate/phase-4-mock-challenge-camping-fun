class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response


    def index 
        render json: Camper.all
    end

    def show 
        camper = Camper.find_by(id: params[:id])
        if camper
        render json: camper, include: :activities
        else
            render json: { error: "Camper not found"}, status: :not_found
        end
    end

    def create 
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end

    private

    def camper_params 
        params.permit(:name, :age)
    end

    def render_unprocessable_entity_response(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end
  
end
