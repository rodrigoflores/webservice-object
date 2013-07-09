require 'faraday'
require 'json'

def retrieve_repos_for(org)
  connection = Faraday.new(:url => 'https://api.github.com') do |faraday|
    faraday.adapter  Faraday.default_adapter
  end

  response = JSON.parse(connection.get("/orgs/#{org}/repos").body)
  response
end

retrieve_repos_for('github').each do |repo|
  puts repo['clone_url']
end