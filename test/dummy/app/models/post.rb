class Post < ActiveRecord::Base
  include PageParts::ActiveRecordExtension
  
  page_parts :title, :content, :suffix => [:ru, :en, :uk]
end
