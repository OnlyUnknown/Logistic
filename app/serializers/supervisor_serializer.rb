class SupervisorSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :name
end
