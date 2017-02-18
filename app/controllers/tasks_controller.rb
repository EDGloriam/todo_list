class TasksController < ApplicationController
	before_action :find_project

	def create
		@task = @project.tasks.create(permitted_params)
		render json: @task
	end

	def update
		@task = @project.tasks.find(params[:id])
		@task.update(permitted_params)
		render json: @task
	end

	def destroy
		@project.tasks.find(params[:id]).destroy
		render json: :ok
	end

	private

	def find_project
		@project = current_user.projects.find(params[:project_id])
	end

	def permitted_params
		params.require(:task).permit(:content)
	end
end