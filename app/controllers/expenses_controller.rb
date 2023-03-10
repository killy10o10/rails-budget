class ExpensesController < ApplicationController
  # GET /expenses or /expenses.json
  def index
    @expenses = Expense.where(author_id: current_user.id)
  end

  # GET /expenses/1 or /expenses/1.json
  def show; end

  # GET /expenses/new
  def new
    @expense = Expense.new
    @categories = current_user.categories
    @expense_categories = @expense.expense_categories.build
  end

  # GET /expenses/1/edit
  def edit
    @expense = Expense.find(params[:id])
    @categories = current_user.categories
    @expense_categories = @expense.expense_categories.build
  end

  # POST /expenses
  def create
    expense = Expense.new(expense_params.except(:expense_categories))
    expense.author_id = current_user.id

    if expense.save
      category = expense_params[:expense_categories][:category_ids][1]
      expense_params[:expense_categories][:category_ids].each do |id|
        expense.expense_categories.create(category_id: id) unless id == ''
      end
      redirect_to category_path(category), notice: 'Budget was successfully created.'
    else
      render expense, alert: 'Something went wrong! Budget expense was not created.'
    end
  end

  # PATCH/PUT /expenses/1
  def update
    expense = Expense.find(params[:id])
    if expense.update(expense_params.except(:expense_categories))
      category = expense_params[:expense_categories][:category_ids][1]
      redirect_to category_path(category), notice: 'Budget expense successfully updated.'
    else
      flash[:alert] = 'Something went wrong! Budget expense was not updated'
      redirect_to edit_expense_path(expense)
    end
  end

  # DELETE /expenses/1
  def destroy
    @expense = Expense.find(params[:id])
    @expo = ExpenseCategory.all.where(expense_id: @expense.id)[0]
    @category = @expo.category
    @expense.destroy
    redirect_to category_path(@category), notice: 'Expense successfully deleted.'
  end

  private

  # Only allow a list of trusted parameters through.
  def expense_params
    params.require(:new_expense).permit(:name, :amount, expense_categories: [category_ids: []])
  end
end
