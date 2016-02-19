class ProviderAuthService
  def self.facebook_auth(access_token)
    graph = Koala::Facebook::API.new(access_token)
    profile = graph.get_object('me')
    user = User.find_or_initialize_by(provider: 'facebook', uid: profile['id'])

    if user.new_record?
      random_password = generate_random_password

      fields = {
          name: profile['name'],
          email: profile['email'],
          password: random_password,
          password_confirmation: random_password
      }
      user.update(fields)
    end

    user
  end

  private
  def self.generate_random_password
    SecureRandom.urlsafe_base64(nil, false)
  end
end