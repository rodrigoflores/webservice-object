require 'faraday'
require 'json'

module Github
  class Organization
    def initialize(organization)
      @organization = organization
    end

    def repos
      connection = Faraday.new(:url => 'https://api.github.com') do |faraday|
        faraday.adapter  Faraday.default_adapter
      end

      response = JSON.parse(connection.get("/orgs/#{@organization}/repos").body)
      response
    end
  end
end

Github::Organization.new('github').repos.each do |repo|
  puts repo['clone_url']
end