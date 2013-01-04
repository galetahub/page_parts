class Post < ActiveRecord::Base
  include PageParts::Extension
  
  page_parts :title, :content, :suffix => [:ru, :en, :uk]
end
