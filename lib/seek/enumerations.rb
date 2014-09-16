module Seek
  class Enumerations
    class << self
      Dir["#{File.expand_path('..', __FILE__)}/enumerations/*.yml"].each do |file|
        resource = File.basename(file, '.yml').to_sym

        send :define_method, resource, ->{ instance_variable_get("@#{resource}") || instance_variable_set("@#{resource}", create_hash_from_yml(resource)) }
      end

      private

      def create_hash_from_yml(resource)
        file = File.expand_path("../enumerations/#{resource}.yml", __FILE__)
        to_open_struct(YAML.load_file(file)['enumerations'][resource.to_sym])
      end

      def to_open_struct(object)
        case object
          when Hash
            object = object.clone
            object.each do |key, value|
              object[key] = to_open_struct(value)
            end
            OpenStruct.new(object)
          when Array
            object = object.clone
            object.map! { |i| to_open_struct(i) }
          else
            object
        end
      end
    end
  end
end
