require 'rails_helper'

RSpec.describe TodosController, type: :controller do
  let(:user) { create(:user) }
  let!(:todo) { create(:todo, user: user) }
  let(:auth_headers) { user.create_new_auth_token }

  before do
    request.headers.merge!(auth_headers)
  end

  describe "GET #index" do
    it "returns all todos for current user" do
      get :index
      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      expect(json).to be_a(Hash)

      # Depending on your controller’s JSON format
      todos = json["todos"] || json
      expect(todos.first["title"]).to eq(todo.title)
    end
  end

  describe "GET #show" do
    it "returns the requested todo" do
      get :show, params: { id: todo.id }
      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      todo_data = json["todo"] || json
      expect(todo_data["id"]).to eq(todo.id)
    end

    it "returns not found for invalid id" do
      get :show, params: { id: 999 }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST #create" do
    it "creates a new todo" do
      expect {
        post :create, params: { todo: { title: "New Todo", description: "New Desc", completed: false } }
      }.to change(Todo, :count).by(1)
      expect(response).to have_http_status(:created)
    end

    it "returns error for invalid params" do
      post :create, params: { todo: { title: "" } }
      expect(response).to have_http_status(:unprocessable_content)
    end
  end

  describe "PUT #update" do
    it "updates an existing todo" do
      put :update, params: { id: todo.id, todo: { title: "Updated Title" } }
      expect(response).to have_http_status(:ok)
      expect(todo.reload.title).to eq("Updated Title")
    end

    it "returns not found for invalid id" do
      put :update, params: { id: 999, todo: { title: "Nope" } }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "DELETE #destroy" do
    it "deletes the todo" do
      expect {
        delete :destroy, params: { id: todo.id }
      }.to change(Todo, :count).by(-1)
      expect(response).to have_http_status(:ok)
    end

    it "returns not found for invalid id" do
      delete :destroy, params: { id: 999 }
      expect(response).to have_http_status(:not_found)
    end
  end
end
