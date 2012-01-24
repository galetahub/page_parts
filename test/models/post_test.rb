require 'test_helper'

class PostTest < ActiveSupport::TestCase

  setup do
    @post = Post.new :is_visible => true
  end
  
  test 'should has page_parts_definitions' do
    assert Post.respond_to?(:page_parts_definitions)
  end
  
  test "should save page parts with new_record" do
    value_ru = "Title ru"
    @post.title_ru = value_ru
    
    value_en = "Title en"
    @post.title_en = value_en
    
    assert_equal @post.page_part(:title_ru).content, value_ru
    assert_equal @post.page_part(:title_en).content, value_en
    assert_equal @post.page_part(:content_ru).content, nil
    
    assert_difference('PagePart.count', 3) do
      @post.save
    end
  end
  
  test "should load page parts into record" do
    @post.title_ru = "Sidebar"
    @post.content_uk = "Main"
    @post.save
    
    @post.reload
    
    assert_equal @post.title_ru, "Sidebar"
    assert_equal @post.content_uk, "Main"
    assert_equal @post.content_ru, nil
    assert_equal @post.content_en, nil
  end
  
  test "should raise error on not registered page part" do
    assert_raise(NoMethodError) do
      @post.title
    end
    
    assert_raise(NoMethodError) do
      @post.content
    end
  end
end
