require 'octokit'

class Repo
  attr_reader :client

  def initialize
    @client = Octokit::Client.new(:login => 'defunkt', :password => '50c6fca13b73252e1eaacd30647a715fcd5dd685')
  end

  def repo
    client.repo('TINYhr/tinypulse')
  end

  def pull_requests
    client.pull_requests('TINYhr/tinypulse')
  end
end
