require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
    test 'render a list of products' do
        get products_path

        assert_response :success
        assert_select '.product', 2
    end
    test 'render a detailed product page' do
        get products_path(products(:one))

        assert_response :success
        assert_select '.title', 'MyString'
        assert_select '.description', 'MyText'
        assert_select '.price', '1'
    end

    test 'render a new product form' do
        get new_product_path

        assert_response :success
        assert_select 'form'
    end

    test 'allow to create a new product' do
        post products_path, params: {
            product: {
                title: 'MyString',
                description: 'MyText',
                price: 1
            }
        }

        assert_redirected_to products_path
        assert_equal flash[:notice], 'Tu producto se ha creado correctamente'
    end

    test 'render an edit product form' do
        get edit_product_path(products(:one))

        assert_response :success
        assert_select 'form'
    end

    test 'allow to update a product' do
        patch product_path(products(:one)), params: {
            product: {
                price: 2
            }
        }

        assert_redirected_to products_path
        assert_equal flash[:notice], 'Tu producto se ha actualizado'
    end

    test 'can delete products' do
        assert_difference('Product.count', -1) do
            delete product_path(products(:one))
        end

        assert_redirected_to products_path
        assert_equal flash[:notice], 'El producto se ha eliminado'
    end
end