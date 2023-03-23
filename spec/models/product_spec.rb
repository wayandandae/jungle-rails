require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do
    it 'is valid with valid attributes' do
      @category = Category.new
      @product = Product.new({
        name: "Some Plant",
        price: 99.99,
        quantity: 1,
        category: @category
      })
      @product.save
      expect(@product).to be_valid
    end
      
    it 'is not valid without a name' do
      @category = Category.new
      @product = Product.new({
        name: nil,
        price: 99.99,
        quantity: 1,
        category: @category
      })
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'is not valid without a price' do
      @category = Category.new
      @product = Product.new({
        name: "Some Plant",
        price_cents: nil,
        quantity: 1,
        category: @category
      })
      @product.save
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'is not valid without a quantity' do
      @category = Category.new
      @product = Product.new({
        name: "Some Plant",
        price: 99.99,
        quantity: nil,
        category: @category
      })
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'is not valid without a category' do
      @category = Category.new
      @product = Product.new({
        name: "Some Plant",
        price: 99.99,
        quantity: 1,
        category: nil
      })
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end

end
