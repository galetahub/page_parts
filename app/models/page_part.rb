class PagePart < ::ActiveRecord::Base
  belongs_to :partable, :polymorphic => true
  
  validates_presence_of :key, :partable_type
  validates_uniqueness_of :key, :scope => [:partable_type, :partable_id]
  
  attr_accessible :key, :content
end
