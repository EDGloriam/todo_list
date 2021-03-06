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

	def sort_tasks
		params[:ids].each_with_index{ |id, index| @project.tasks.find(id).update_attribute(:position, index) }
		render json: { status: :ok }
	end

	private

		def find_project
			@project = current_user.projects.find(params[:project_id])
		end

		def permitted_params
			params.require(:task).permit(:content, :status, :position)
		end
end