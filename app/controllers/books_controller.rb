class BooksController < ApplicationController
  before_action :set_library
  before_action :set_book, only: [:show, :update, :destroy]

  # GET /books
  def index
    render_success Book.all
  end

  # GET /books/1
  def show
    render_success @book
  end

  # POST /books
  def create
    @book = Book.create!(book_params)
    render_success @book, :created
  end

  # PATCH/PUT /books/1
  def update
    @book.update!(book_params)
    render_success @book
  end

  # DELETE /books/1
  def destroy
    @book.destroy!
  end

  private

  def set_library
    @library = Library.find(params[:library_id])
  end

  def set_book
    @book = @library.books.find_by!(id: params[:id])
  end

  def book_params
    params.require(:book).permit(:title)
  end
end
