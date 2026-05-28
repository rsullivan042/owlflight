class Admin::TasksController < Admin::BaseController
  before_action :set_project

  def new
    @task = @project.tasks.new
  end

  def create
    @task = @project.tasks.new(task_params)

    if @task.save
      redirect_to admin_project_path(@project)
    else
      render :new
    end
  end

  def edit
    @task = @project.tasks.find(params[:id])
  end

  def update
    @task = @project.tasks.find(params[:id])

    if @task.update(task_params)
      redirect_to admin_project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    @task = @project.tasks.find(params[:id])

    @task.destroy

    redirect_to admin_project_path(@project)
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:description, :completed)
  end
end
