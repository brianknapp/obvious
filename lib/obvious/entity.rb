
module Obvious

  module EntityMixin 
    class << self
      def included(base)
        base.extend ClassMethods
      end
    end

    module ClassMethods
      attr_reader :shape
      attr_reader :validations

      def value name, type 
        name = name.to_sym
        @shape ||= {}
        @shape[name] = type   
        define_method(name) { @values[name] }
      end

      def validation name, method
        name = "#{name}_validation".to_sym
        @validations ||= [] 
        @validations << name 
        define_method(name) { instance_exec &method }
      end

      def to_hash
        hash = {}
        @values.each do |k, v| 
          hash[k] = v
        end 
        hash
      end

    end
  end

  class Entity
    include EntityMixin

    def initialize input
      shape = self.class.shape
      validations = self.class.validations || []

      @values = {}
      input.each do |k, v|
        unless shape[k]
          raise StandardError.new "Invalid input field: #{k}" 
        else
          @values[k] = v
        end
      end 

      freeze
      
      shape.each do |k, v|
        unless @values[k].class == v
          msg = "Validation Error: Invalid value for #{k}, should be a #{v}"
          raise StandardError.new msg 
        end
      end

      validations.each { |method| send method } 
    end 

  end
end

