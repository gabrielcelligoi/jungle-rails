require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'creates a new product when all fields are setted' do
      @category = Category.create(name: 'Furniture')
      @category.save

      @product = Product.new(name: 'Sofa', price: 300, quantity: 7, category: @category)
      @product.save

      expect(@product).to be_valid
    end

    it 'throws error when no name is given to the product' do
      @category = Category.create(name: 'Furniture')
      @category.save

      @product = Product.new(name: nil, price: 300, quantity: 7, category: @category)
      @product.save

      expect(@product).not_to be_valid
    end

    it 'throws an error when no price is given to the product' do
      @category = Category.create(name: 'Furniture')
      @category.save

      @product = Product.new(name: 'Sofa', price: nil, quantity: 7, category: @category)
      @product.save

      expect(@product).not_to be_valid
    end

    it 'thros an error when no quantity is given to the product' do
      @category = Category.create(name: 'Furniture')
      @category.save

      @product = Product.new(name: 'Sofa', price: 300, quantity: nil, category: @category)
      @product.save

      expect(@product).not_to be_valid
    end
  end
end
