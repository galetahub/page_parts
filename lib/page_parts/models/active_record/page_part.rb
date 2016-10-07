class PagePart < ::ActiveRecord::Base
  belongs_to :partable, polymorphic: true

  validates :key, presence: true
end
