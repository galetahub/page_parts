class Category < ActiveRecord::Base
  include PageParts::ActiveRecordExtension
  
  validates_presence_of :title
  
  page_parts :content, :sidebar
end
