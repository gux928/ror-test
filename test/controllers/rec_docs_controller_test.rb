require 'test_helper'

class RecDocsControllerTest < ActionDispatch::IntegrationTest
  test "should get print" do
    get rec_docs_print_url
    assert_response :success
  end

end
