# frozen_string_literal: true
require 'http'
require 'yaml'
require 'json'

require 'webmock'
include WebMock::API
WebMock.enable!

FB_TOKEN_URL = 'https://graph.facebook.com/v2.8/oauth/access_token'
CREDENTIALS = YAML.load(File.read('config/credentials.yml'))

stub_request(:get, FB_TOKEN_URL).with(
  query: { 'client_id' => CREDENTIALS[:client_id],
           'client_secret' => CREDENTIALS[:client_secret],
           'grant_type' => 'client_credentials' }
).to_return(
  status: 200,
  body: { access_token: CREDENTIALS[:access_token] }.to_json
)

response = HTTP.get(
  FB_TOKEN_URL,
  params: { 'client_id' => CREDENTIALS[:client_id],
            'client_secret' => CREDENTIALS[:client_secret],
            'grant_type' => 'client_credentials' }
)

puts response.status
puts response.body.to_s
