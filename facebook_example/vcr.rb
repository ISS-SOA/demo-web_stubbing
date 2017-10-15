# frozen_string_literal: true

require 'http'
require 'yaml'

require 'vcr'
require 'webmock'

FB_TOKEN_URL = 'https://graph.facebook.com/v2.8/oauth/access_token'
CREDENTIALS = YAML.load(File.read('config/credentials.yml'))

VCR.configure do |c|
  c.cassette_library_dir = 'cassettes'
  c.hook_into :webmock
end

VCR.insert_cassette 'token', record: :new_episodes

response = HTTP.get(
  FB_TOKEN_URL,
  params: { 'client_id' => CREDENTIALS[:client_id],
            'client_secret' => CREDENTIALS[:client_secret],
            'grant_type' => 'client_credentials' }
)

puts response.status
puts response.body.to_s

VCR.eject_cassette
