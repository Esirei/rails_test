require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @category = Category.create(name: 'books')
    @category2 = Category.create(name: 'programming')
  end

  test 'should show categories listing' do
    get categories_path
    assert_template 'categories/index'
    assert_select 'a[href=?]', category_path(@category), text: @category.name
    assert_select 'a[href=?]', category_path(@category2), text: @category2.name
    assert_difference 'Category.count', 1 do
      post_via_redirect categories_path, category: { name: 'sports' }
    end
    assert_template 'categories/index'
    assert_match 'sports', response.body
  end

  test 'invalid category submission results in failure' do
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, category: { name: '' }
    end
    assert_template 'categories/index'
    assert_select 'h2.panel-title' #from shared errors partial
    assert_select 'div.panel-body'
  end

end