require 'omniauth-oauth2'
require OmniAuth::Strategies::GitHub

OmniAuth::Strategies::GitHub.raw_info do
  access_token.options[:mode] = :header
  @raw_info ||= access_token.get('user').parsed
end
