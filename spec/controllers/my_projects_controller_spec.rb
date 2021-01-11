require 'rails_helper'

def setup_logged_in
  expect_any_instance_of(ApplicationController).to receive(:logged_in?).and_return(true)
  expect_any_instance_of(ApplicationController).to receive(:current_user).and_return(
      FactoryBot.create(:user))
end

describe MyProjectsController, type: :controller do

end
