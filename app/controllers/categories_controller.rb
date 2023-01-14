class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]

  # GET /categories or /categories.json
  def index
    @categories = current_user.categories.order(created_at: :desc)
    # @categories = current_user.categories.includes(:expenses)
    @total = calculate_total
  end

  # GET /categories/1
  def show
    @category = Category.find(params[:id])
    @expenses = ExpenseCategory.all.where(category_id: @category.id).includes(:expense).order(created_at: :desc)
    @total_expenses = obtain_total
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  def create
    @category = Category.new(category_params)
    # user = current_user
    # @category.user = user
    if @category.save
      redirect_to @category, notice: 'Budget category successfully created'
    else
      render :new, notice: 'Something went wrong😱 Budget category was not created'
    end
  end

  # PATCH/PUT /categories/1
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to category_url(@category), notice: 'Category was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_url, notice: 'Budget category was successfully destroyed.'
    # else
    #   render @category, notice: 'Something went wrong! Budget category was not destroyed'
    # end
  end

  private

  def obtain_total
    sum = 0
    @expenses.each do |exp|
      sum += exp.expense.amount.to_i
    end
    sum
  end

  def calculate_total
    sum = 0
    exp = ExpenseCategory.all
    exp.each do |cat|
      sum += cat.expense.amount.to_i
    end
    sum
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:category).permit(:name, :icon).merge(author_id: current_user.id)
  end
end
