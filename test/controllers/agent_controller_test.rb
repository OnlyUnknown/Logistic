require 'test_helper'

class AgentControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get agent_show_url
    assert_response :success
  end
end
