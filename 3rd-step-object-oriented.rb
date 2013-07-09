require 'faraday'
require 'json'

module Github
  class Organization
    def initialize(organization)
      @organization = organization
    end

    def repos
      @repos ||= JSON.parse(connection.get(repos_url).body)
    end

    private

    def connection
      Faraday.new(:url => 'https://api.github.com') do |faraday|
        faraday.adapter  Faraday.default_adapter
      end
    end

    def repos_url
      "/orgs/#{@organization}/repos"
    end
  end
end

Github::Organization.new('github').repos.each do |repo|
  puts repo['clone_url']
end