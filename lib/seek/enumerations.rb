module Seek
  class Enumerations
    class << self
      Dir["#{File.expand_path('..', __FILE__)}/enumerations/*.yml"].each do |file|
        resource = File.basename(file, '.yml').to_sym

        send :define_method, resource, ->{
          result = instance_variable_get("@#{resource}") || instance_variable_set("@#{resource}", create_hash_from_yml(resource))

          result.define_singleton_method(:select_options) do
            result.map { |enumeration_item| [enumeration_item.description, enumeration_item.id] }
          end unless result.respond_to?(:select_options)

          result
        }
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

# # In order to use the MarketSegment API:
# result = HTTParty.post(
#   'http://webservices.seek.com.au/MarketSegment.asmx/GetMarketClassifiers',
#   body: { 'marketSegment' => 'Main' }
# )
#
# h = result['SpecificClassification']['list'].inject({}) do |hash, list|
#   hash[list['value']] = list['listItem'].map { |i| i['value'] } if list['listItem']
#   hash
# end
