class PlantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  def index
    render json: Plant.all,  status: :ok
  end

  def show
    plant = find_plant
    render json: plant, except: [:created_at, :updated_at], status: :ok
  end

  def create
    plant = Plant.create(plants_params)
    render json: plant, except: [:created_at, :updated_at], status: :created
  end

  def destroy
    plant = find_plant
    plant.destroy
    render json: { message: 'plant deleted' }, status: :no_content
  end

  def update
    plant = find_plant
    plant.update(plants_params)
    render json: plant, except: [:updated_at, :created_at], status: :accepted
  end

  private

  def render_not_found_response
    render json: { error: 'Not Found' }, status: :not_found
  end

  def find_plant
    plant = Plant.find(params[:id])
  end

  def plants_params
    params.permit(:name, :price, :image)
  end

end
