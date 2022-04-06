class Admin::DashboardController < ApplicationController
  # http_basic_authenticate_with name: "Jungle", password: "book"
  http_basic_authenticate_with name: ENV['AUTH_ADMIN_NAME'], password: ENV['AUTH_ADMIN_PASSWORD']

  def show
    @products_count = Product.count(:name)
    @categories_count = Category.count(:name)
  end
end
