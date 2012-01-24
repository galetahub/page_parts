require 'active_support/concern'

module PageParts
  module ActiveRecordExtension
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
              page_part(method_name).try(:content)
            end
            
            define_method("#{method_name}=") do |value|
              record = page_part(method_name)
              record.content = value
            end
          end
        end
      end
    end

    
    # Find page part by key or build new record
    def find_or_build_page_part(attr_name)
      key = normalize_page_part_key(attr_name)
      self.page_parts.where(:key => key).first || self.page_parts.build(:key => key)
    end
    
    # Save page parts records into one hash
    def page_part(attr_name)
      key = normalize_page_part_key(attr_name)
      @page_part ||= {}
      @page_part[key] ||= find_or_build_page_part(key)
    end
    
    protected
    
      def normalize_page_part_key(value)
        key = value.to_s.downcase.strip
        
        unless self.page_parts_definitions[:keys].include?(key)
          raise NoMethodError, "Page part #{key} not registered"
        end
        
        key
      end
      
  end
end
