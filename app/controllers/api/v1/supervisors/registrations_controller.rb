# frozen_string_literal: true

class Api::V1::Supervisors::RegistrationsController < Devise::RegistrationsController
  respond_to :json
end
