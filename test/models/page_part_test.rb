require 'test_helper'

class PagePartTest < ActiveSupport::TestCase
  # called before every single test
  def setup
    @page = PagePart.new(:key => 'somekey')
    @page.partable_type = 'Category'
    @page.partable_id = 1
  end
  
  test "truth" do
    assert_kind_of Class, PagePart
  end
  
  test 'should create new record with valid attributes' do
    @page.save!
  end
  
  test 'should not be valid with empty key' do
    @page.key = nil
    assert !@page.valid?
  end
  
  test 'should not be valid with not uniq key' do
    @page.update_attribute(:key, 'test')
    
    @part = PagePart.new(:key => 'test')
    @part.partable_type = 'Category'
    @part.partable_id = 1
    
    assert !@part.valid?
  end
end
