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
    @borrow = Borrow.create(book_id: params[:book_id],user_id: params[:user_id])
    redirect_to books_path
  end

  def update
    begin
      @borrow = Borrow.find(params[:id])
      @borrow.update(borrow_params)
      if @borrow.return_date.nil?
        @borrow.update(fine: 0)
      else
        @borrow.update(fine: (@borrow.return_date - @borrow.due_date)*5)
      end
      @book = Book.find(@borrow.book_id)
      ( @book.status != 'issued' ) ? @book.update(status: 'issued'): @book.update(status: 'available')
    rescue 
      redirect_to @borrow
    end
    return
  end

  def destroy
    begin
    @borrow = Borrow.find(params[:id])
    @book = Book.find(@borrow.book_id)
    @borrow.destroy
    @book.update(status: 'available')
    rescue 
    redirect_to borrows_path
    end
    return
  end

  def issue_book
    @borrow = Borrow.find(params[:id])
    render :issue_book
  end

  def return_book
    @borrow = Borrow.find(params[:id])
    render :return_book
  end
  
  protected
    def borrow_params
      params.require(:borrow).permit(:user_id, :book_id, :issue_date, :due_date, :fine, :return_date, :flag)
    end
end
