class Api::V1::BookItemsController < ApplicationController

  before_action :set_book_item, only: [:update, :destroy]

  def index
    render json: current_user.book_items.order(:id)
  end

  def create
    @book_item = current_user.book_items.build(book_item_params)
    if @book_item.save
      render json: @book_item, status: :created
    else
      render json: {error: true, message: "Invalid book item"}, status: :not_acceptable
    end
  end

  def update
    if book_item_is_restricted
      render json: {error: true, message: "Can't change this book item."}, status: :not_acceptable
    else
      if @book_item.update(book_item_params)
        render json: @book_item, status: :accepted
      else
        render json: {error: true, message: "Invalid book item"}, status: :not_acceptable
      end
    end
  end

  def destroy
    if @book_item && !book_item_is_restricted
      @book_item.destroy
      render json: @book_item, status: :accepted
    else
      render json: {error: true, message: "Could not delete this book item"}, status: :not_acceptable
    end
  end

  private

  def book_item_params
    params.require(:book_item).permit(:title, :role, :author, :user_id)
  end

  def set_book_item
    @book_item = BookItem.find(params[:id])

    if @book_item.user != current_user
      @book_item = nil
    end
  end

  def book_item_is_restricted
    if @book_item.title == "Prepared Sides"
      return true
    else
      return false
    end
  end

end
