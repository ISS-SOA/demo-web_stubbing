# frozen_string_literal: true

require 'http'
require 'yaml'

require 'webmock'
include WebMock::API
WebMock.enable!

CREDENTIALS = YAML.load(File.read('config/secrets.yml'))
GH_TOKEN = CREDENTIALS['gh_token']
CORRECT = YAML.safe_load(File.read('spec/fixtures/gh_results.yml'))

github_url = 'https://api.github.com/repos/soumyaray/YPBT-app'

stub_request(:get, github_url).with(
  headers: { 'Accept' => 'application/vnd.github.v3+json',
             'Authorization' => "token #{GH_TOKEN}" }
).to_return(
  status: 200,
  body: CORRECT.to_json
)

response = HTTP.get(
  github_url,
  headers: { 'Accept' => 'application/vnd.github.v3+json',
             'Authorization' => "token #{GH_TOKEN}" }
)

puts response.status
# 200 OK

puts response.body
# {"size":551,"owner":{"login":"soumyaray","id":1926704,"avatar_url":...
