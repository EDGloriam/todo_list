class ProjectsController < ApplicationController
	def index
		@projects = current_user.projects
		render 'index'
	end

	def create
		@project = current_user.create(permitted_params)
		render json: @project
	end

	def update
		@project = current_user.projects.find(params[:id])
		@project.update(permitted_params)
		render json: @project
	end

	def show
		@project = current_user.projects.find(params[:id])
		render json: @project
	end

	def destroy
		@project = current_user.projects.find(params[:id])
		@project.destroy
		render json: :ok
	end

	private

	def permitted_params
		params.require(:project).permit(:name)
	end
end