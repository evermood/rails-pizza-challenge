def current_user(stubs = {})
  @mock_current_user ||= mock_model(User, :name => 'Mock Current User').tap do |user|
    stubs.reverse_merge! :is? => true, landing: nil
    #  user.stub(stubs)
    stubs.each do |k, v|
      allow(user).to receive(k) {v}
    end
  end
end
