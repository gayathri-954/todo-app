class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo, only: [:show, :update, :destroy]

  # GET /todos
  def index
    todos = current_user.todos
    if todos.any?
      render json: { todos: todos }, status: :ok
    else
      render json: { message: "No todos as of now" }, status: :ok
    end
  end

  # GET /todos/:id
  def show
    if @todo
      render json: { todo: @todo }, status: :ok
    else
      render json: { error: "Todo not found" }, status: :not_found
    end
  end

  # POST /todos
  def create
    todo = Todo.new(todo_params.merge(user_id: current_user.id))
    if todo.save
      render json: { todo: todo, message: "Todo created successfully" }, status: :created
    else
      render json: { errors: todo.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /todos/:id
  def update
    unless @todo
      return render json: { error: "Todo not found" }, status: :not_found
    end

    if @todo.update(todo_params)
      render json: { todo: @todo, message: "Todo updated successfully" }, status: :ok
    else
      render json: { errors: @todo.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /todos/:id
  def destroy
    if @todo
      @todo.destroy
      render json: { message: "Todo deleted successfully" }, status: :ok
    else
      render json: { error: "Todo not found" }, status: :not_found
    end
  end

  private

  def set_todo
    @todo = current_user.todos.find_by(id: params[:id])
  end

  def todo_params
    params.require(:todo).permit(:title, :description, :completed)
  end
end
