# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :find_books, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit]

  def new
    @book = current_user.books.build
    @categories = Category.all.map{ |c| [c.name, c.id] } #to fetch all the categories
  end

  def create
    @book = current_user.books.build(book_params)
    @book.category_id = params[:category_id]
    if @book.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def index
  	if params[:category].blank?
    	@books = Book.all.order('created_at DESC')
    else
    	@category_id = Category.find_by(name: params[:category]).id
    	@books = Book.where(category_id: @category_id)
    end
  end

  def show

    if @book.reviews.blank?
      @average_rating = 0
    else
      @average_rating = @book.reviews.average(:rating).round(2)
    end
  end

  def edit
    authorize @book
   @categories = Category.all.map{ |c| [c.name, c.id] }
  end

  def update
    @book.category_id = params[:category_id]
    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to root_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :description, :author, :category_id, :image)
  end

  def find_books
    @book = Book.find(params[:id])
  end
end
