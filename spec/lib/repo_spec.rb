require 'repo'
require 'spec_helper'

describe Repo do
  describe '#initialize' do
    it 'inits github client' do
      repo = Repo.new
      expect(repo.client).not_to be_nil

      github_repo = repo.repo

      expect(github_repo).not_to be_nil
      expect(github_repo['organization']['repos_url']).to eq 'https://api.github.com/users/TINYhr/repos'
    end
  end

  describe '#repo' do
    it 'inits github repo' do
      github_repo = Repo.new.repo

      expect(github_repo).not_to be_nil
      expect(github_repo['organization']['repos_url']).to eq 'https://api.github.com/users/TINYhr/repos'
    end
  end

  describe '#pull_requests' do
    it 'fetchs pull requests' do
      pull_requests = Repo.new.pull_requests
      expect(pull_requests).not_to be_nil
    end
  end
end
