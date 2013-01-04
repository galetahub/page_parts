class Category < ActiveRecord::Base
  include PageParts::Extension
  
  validates_presence_of :title
  
  page_parts :content, :sidebar
end
