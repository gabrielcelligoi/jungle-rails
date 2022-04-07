class Admin::CategoriesController < ApplicationController

  http_basic_authenticate_with name: ENV['AUTH_ADMIN_NAME'], password: ENV['AUTH_ADMIN_PASSWORD']
  
  def index
  end

  def new
  end

  def create
  end
end
