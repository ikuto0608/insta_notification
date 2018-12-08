require 'net/http'
require 'json'

INSTA_URL = 'https://www.instagram.com/chinatown_stropky/'.freeze
SLACK_URL = 'https://slack.com/api/chat.postMessage'.freeze

def is_ready_to_book(event:, context:)
  insta_uri = URI.parse(INSTA_URL)
  insta_uri.query = URI.encode_www_form({ hl: 'en' })
  https = Net::HTTP.new(insta_uri.host, insta_uri.port)
  https.use_ssl = true
  request = Net::HTTP::Get.new(insta_uri.request_uri)
  response = https.request(request)

  return true if response.body.include?('Books reopen soon')

  slack_uri = URI.parse(SLACK_URL)
  https = Net::HTTP.new(slack_uri.host, slack_uri.port)
  https.use_ssl = true
  header = {
    'Content-Type' => 'application/json; charset=iso-8859-1',
    'Authorization' => "Bearer #{ENV['SLACK_TOKEN']}"
  }
  request = Net::HTTP::Post.new(slack_uri.path, header)
  request.body = {
    channel: ENV['SLACK_CHANNEL'],
    as_user: true,
    text: "The status has changed! Go to #{INSTA_URL}"
  }.to_json
  https.request(request)

  true
end
