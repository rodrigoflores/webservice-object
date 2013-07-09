require 'faraday'
require 'faraday_middleware'

module Github
  class Organization
    def initialize(organization)
      @organization = organization
    end

    def repos
      @repos ||= get(repos_url)
    end

    def info
      @info ||= get(info_url)
    end

    private

    def connection
      @connection ||= Faraday.new(:url => 'https://api.github.com') do |faraday|
        faraday.adapter  Faraday.default_adapter
        faraday.response :json, :content_type => /\bjson$/
      end
    end

    def get(url)
      connection.get(url).body
    end

    def repos_url
      "/orgs/#{@organization}/repos"
    end

    def info_url
      "/orgs/#{@organization}"
    end
  end
end

org = Github::Organization.new('github')

puts org.info['name']
org.repos.each do |repo|
  puts repo['clone_url']
end