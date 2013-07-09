require 'faraday'
require 'json'

module Github
  class Organization
    def initialize(organization)
      @organization = organization
    end

    def repos
      @repos ||= get(repos_url)
    end

    private

    def connection
      Faraday.new(:url => 'https://api.github.com') do |faraday|
        faraday.adapter  Faraday.default_adapter
      end
    end

    def get(url)
      JSON.parse(connection.get(url).body)
    end

    def repos_url
      "/orgs/#{@organization}/repos"
    end
  end
end

Github::Organization.new('github').repos.each do |repo|
  puts repo['clone_url']
end