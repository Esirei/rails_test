require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @category = Category.create(name: 'sports')
    @user = User.create(username: 'john', email: 'john@example.com', password: 'password', admin: true)
  end

  test 'should get categories index' do
    get categories_path
    assert_response :success
  end

  test 'should get new' do
    session[:user_id] = @user.id
    get new_category_path
    assert_response :success
  end

  test 'should get show' do
    get(category_path, params: { id: @category.id } )
    assert_response :success
  end

  test 'should redirect create when admin not logged in' do
    assert_no_difference 'Category.count' do
      get new_category_path, params: { category: { name: 'sports' } }
    end
    assert_redirected_to categories_path
  end

end
