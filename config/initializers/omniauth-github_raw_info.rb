require 'omniauth-oauth2'

OmniAuth::Strategies::GitHub.class_eval do
  def raw_info
    access_token.options[:mode] = :header
    @raw_info ||= access_token.get('user').parsed
  end
end
