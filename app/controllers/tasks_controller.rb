class TasksController < ApplicationController
  # Show all tasks
  def index
    @tasks = Task.all
  end

  # Show a specific task by its ID
  def show
    @task = Task.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to tasks_path, alert: "Task not found"  # Handle error if task not found
  end

  # Initialize a new task for the form
  def new
    @task = Task.new
  end

  # Create a new task
  def create
    @task = Task.new(task_params)  # Build the task from the form data
    if @task.save
      redirect_to tasks_path, notice: 'Task was successfully created.'  # Redirect back to the task list
    else
      render :new  # If creation failed, re-render the form
    end
  end

  # Fetch the task to edit
  def edit
    @task = Task.find(params[:id])
  end

  # Update an existing task
  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])  # Find the task to delete
    @task.destroy  # Destroy the task

    redirect_to tasks_path, notice: 'Task was successfully deleted.'  # Redirect back to tasks list after deletion
  end

  private

  # Allow only permitted task parameters
  def task_params
    params.require(:task).permit(:title, :details)
  end
end
