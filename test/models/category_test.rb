require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  setup do
    @category = Category.new title: 'Test category'
  end

  test "truth" do
    assert_kind_of Class, Category
  end

  test 'should has page_parts_definitions' do
    assert Category.respond_to?(:page_parts_definitions)
  end

  test "should save page parts with new_record" do
    value = "Sidebar content"
    @category.sidebar = value

    assert_equal @category.send(:_page_part, :sidebar).content, value
    assert_equal @category.send(:_page_part, :content).content, nil

    assert_difference('PagePart.count', 2) do
      @category.save
    end
  end

  test "should load page parts into record" do
    @category.sidebar = "Sidebar"
    @category.content = "Main"
    @category.save

    @category.reload

    assert_equal @category.sidebar, "Sidebar"
    assert_equal @category.content, "Main"
  end

  test "should update page parts" do
    @category.sidebar = "Sidebar"
    @category.content = "Main"
    @category.save

    @category.reload

    assert_equal @category.sidebar, "Sidebar"
    assert_equal @category.content, "Main"

    @category.update_attributes(sidebar: "Sidebar 2", content: "Main 2")

    @category.reload

    assert_equal @category.sidebar, "Sidebar 2"
    assert_equal @category.content, "Main 2"
  end

  test "should raise error on not registered page part" do
    assert_raise(NoMethodError) do
      @category.wrong_method
    end
  end
end
