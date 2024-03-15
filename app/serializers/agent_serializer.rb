class AgentSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :name
end
