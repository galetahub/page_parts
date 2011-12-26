require 'test_helper'

class PagePartsTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, PageParts
  end
  
  test 'shound be included by Category' do
    assert Category.respond_to?(:page_parts)
  end
end
