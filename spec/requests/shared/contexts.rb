# frozen_string_literal: true

RSpec.shared_context 'do_login_first' do
  before do
    # There is a default user on seed admin@ticketfy
    user = User.find_by(email: 'admin@ticketfy') || create(:user)
    sign_in user
  end
end
