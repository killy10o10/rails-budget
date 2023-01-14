require 'rails_helper'

RSpec.describe Expense, type: :model do
  before :each do
    @user = User.new(name: 'John Doe', email: 'test@email.com', password: 'password', password_confirmation: 'password')
    @category = Category.new(name: 'Test Category', icon: 'test_icon.url')
    @category.user = @user
    @expense = Expense.new(name: 'Test Expense', amount: 5)
    @expense.user = @user
  end

  context 'Validations:' do
    it 'Expense is valid with valid attributes' do
      @expense.save
      expect(@expense).to be_valid
    end
  end

  context 'Details Validations:' do
    it 'Expense name should match input' do
      @expense.save
      expect(@expense.name).to eql 'Test Expense'
    end

    it 'Expense amount should match input' do
      @expense.save
      expect(@expense.amount).to eql 5
    end
  end
end
