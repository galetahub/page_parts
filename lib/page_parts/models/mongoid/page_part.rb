require 'mongoid'

class PagePart
  include Mongoid::Document
  include Mongoid::Timestamps

  # Columns
  field :key, :type => String
  field :content, :type => String

  index({:key => 1})

  # Relations
  belongs_to :partable, :polymorphic => true, :index => true
  
  validates_presence_of :key, :partable_type
  validates_uniqueness_of :key, :scope => [:partable_type, :partable_id]  
end
