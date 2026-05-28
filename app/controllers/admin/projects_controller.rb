class Admin::ProjectsController < Admin::BaseController
  def index
    @projects = Project.order(updated_at: :desc)
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    Project.clear_current! if project_params[:current]

    if @project.save
      redirect_to admin_projects_path, notice: "Project created successfully."
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])

    Project.clear_current!(except: @project) if project_params[:current]

    if @project.update(project_params)
      redirect_to admin_projects_path, notice: "Project successfully updated."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @project = Project.find(params[:id])

    @project.destroy

    redirect_to admin_projects_path, notice: "Project deleted successfully."
  end

  private

  def project_params
    params.require(:project).permit(:name, :subdomain, :description, :current, :tech_stack_input)
  end
end
