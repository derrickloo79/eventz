class CategoriesController < ApplicationController
    before_action :set_category, only: [:show, :edit, :update, :destroy]
    before_action :require_signin

    def index
        @categories = Category.all.order("name")
    end

    def show
        @events = @category.events
    end

    def new
        @category = Category.new
    end

    def create
        @category = Category.new(category_params)
        if @category.save
            redirect_to categories_path, notice: "Category successfully added!"
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit

    end

    def update
        if @category.update(category_params)
            redirect_to categories_path, notice: "Category successfully updated!"
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @category.destroy
        redirect_to categories_path, status: :see_other, notice: "Category successfully deleted!"
    end
private

    def category_params
        params.require(:category).
            permit(:name)
    end

    def set_category
        @category = Category.find_by!(slug: params[:id])
    end
end
