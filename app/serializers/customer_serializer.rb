class CustomerSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :name
end
