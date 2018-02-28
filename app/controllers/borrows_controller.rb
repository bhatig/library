class BorrowsController < ApplicationController
  def index
   @borrows =  Borrow.all
  end

  def show
    @borrow = Borrow.find(params[:id])
  end 

  def new
    @borrow = Borrow.new
  end

  def create
    borrow = Borrow.new
    Borrow.create(borrow_params)
    redirect_to books_path
  end

  def update
    begin
      params[:issue_date] = Date.today
      params[:due_date] = params[:issue_date] + 10
      params[:flag] = true
      @borrow = Borrow.find(params[:id])
      @borrow.update(borrow_params)
      @book = Book.find(@borrow.book_id)
      @book.update(status: 'issued')
    rescue
      redirect_to borrows_path
    end
      return

  end

  def destroy
    @borrow = Borrow.find(params[:id])
    @borrow.destroy
    redirect_to borrows_path
  end

  def return_book
    begin
    @borrows = Borrow.where(user_id: params[:user_id]).where(book_id: params[:book_id]).limit(1)
    params[:return_date] = Date.today + 15
    params[:fine] =( params[:return_date] - @borrows.first.due_date.to_date).to_i * 10
    @borrows.first.update(borrow_params)
    @borrow =    @borrows.first      
    @book = Book.find(params[:book_id])
    @book.update(status: 'available')
    rescue 
      redirect_to @borrow  
    end
    return  
  end
  protected
    def borrow_params
      params.permit(:user_id, :book_id, :issue_date, :due_date, :fine, :return_date, :flag)
    end
end
