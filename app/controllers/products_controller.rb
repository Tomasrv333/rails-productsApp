class ProductsController < ApplicationController

    def index
        @products = Product.with_attached_photo.all
    end

    def show
        product
    end

    def new
        @product = Product.new
    end

    def create        
        @product = Product.new(product_params)

        if @product.save
            redirect_to products_path, notice: 'Tu producto se ha creado correctamente'
        else
            render :new, status: :unprocessable_entity 
        end
    end 

    def edit
        product
    end

    def update
        if product.update(product_params)
            redirect_to products_path, notice: 'Tu producto se ha actualizado'
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        product.destroy

        redirect_to products_path, notice: 'El producto se ha eliminado', status: :see_other
    end

    # def due_date
        
    # end
    
    private

    def product_params
        params.require(:product).permit(:title, :description, :price, :photo, :due_date)
    end

    def product
        @product = Product.find(params[:id])
    end
end