module Repositories
  class Destroy
    def initialize(repository)
      @repository = repository
    end

    def self.execute(repository)
      new(repository).execute
    end

    def execute
      FileUtils.rm_rf(repository.path)
      client = Octokit::Client.new(
        login: Rails.application.secrets.github_access_account,
        password: Rails.application.secrets.github_access_token
      )
      client.remove_hook(repository.name, repository.hook_id)
      repository.destroy
    end

    private

    attr_reader :repository
  end
end
