require 'active_support/concern'

module PageParts
  module Extension
    extend ActiveSupport::Concern
    
    included do
      class_attribute :page_parts_definitions, :instance_writer => false
      self.page_parts_definitions = { :keys => [] }
          
      has_many :page_parts, :as => :partable, :dependent => :destroy, :autosave => true
        
      accepts_nested_attributes_for :page_parts, :reject_if => :all_blank, :allow_destroy => true
    end
    
    module ClassMethods
      ## PageParts
      # Enable page parts in your model:
      #
      #   page_parts :main, :left, :sidebar, :suffix => [:ru, :en, :uk]
      #
      def page_parts(*args)
        options = { :suffix => [nil] }.merge(args.extract_options!)
        
        args.each do |attr_name|
          Array.wrap(options[:suffix]).each do |suffix|
            method_name = [attr_name, suffix].compact.map(&:to_s).join('_')
            self.page_parts_definitions[:keys] << method_name
                    
            define_method(method_name) do
              _page_part(method_name).try(:content)
            end
            
            define_method("#{method_name}=") do |value|
              record = _page_part(method_name)
              record.content = value
            end
          end
        end
      end
    end
    
    # Find page part by key or build new record
    def find_or_build_page_part(attr_name)
      key = normalize_page_part_key(attr_name)
      self.page_parts.detect { |record| record.key.to_s == key } || self.page_parts.build(:key => key)
    end
    
    def reload(options = nil)
      @cached_page_parts = nil
      super
    end
    
    protected
    
      # Save page parts records into one hash
      def _page_part(attr_name)
        key = normalize_page_part_key(attr_name)
        @cached_page_parts ||= {}
        @cached_page_parts[key] ||= find_or_build_page_part(key)
      end
    
      def normalize_page_part_key(value)
        key = value.to_s.downcase.strip
        
        unless self.page_parts_definitions[:keys].include?(key)
          raise NoMethodError, "Page part #{key} not registered"
        end
        
        key
      end
      
  end
end
