class Admin::ProjectsController < Admin::BaseController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to [ :admin, @project ], notice: "Project created successfully."
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to [ :admin, @project ], notice: "Project successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to admin_projects_path, notice: "Project deleted successfully."
  end

  private

  def project_params
    params.require(:project).permit(:name, :subdomain, :description)
  end
end
