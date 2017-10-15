# frozen_string_literal: true

require 'http'
require 'yaml'

require 'vcr'
require 'webmock'

CREDENTIALS = YAML.load(File.read('config/secrets.yml'))
GH_TOKEN = CREDENTIALS['gh_token']

VCR.configure do |c|
  c.cassette_library_dir = 'cassettes'
  c.hook_into :webmock
end

VCR.insert_cassette 'repo', record: :new_episodes

github_url = 'https://api.github.com/repos/soumyaray/YPBT-app'

response = HTTP.get(
  github_url,
  headers: { 'Accept' => 'application/vnd.github.v3+json',
             'Authorization' => "token #{GH_TOKEN}" }
)

puts response.status
puts response.body.to_s

VCR.eject_cassette
