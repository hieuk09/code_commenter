class ReviewsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    raw_data = JSON.parse(request.raw_post)
    action = raw_data.fetch('action')
    if ['opened', 'reopened', 'synchronize'].include?(action)
      run_pronto
      render json: { message: 'success' }, status: 200
    else
      render json: { message: 'nothing to do here' }, status: 200
    end
  end

  private

  def run_pronto
    pr_params = params.fetch(:pull_request)
    repository_params = params.fetch(:repository)
    repo = Repository.find_by!(name: repository_params.fetch(:full_name))

    formatter = Pronto::Formatter::GithubPullRequestFormatter.new

    path = repo.path
    git_repo = Rugged::Repository.new(path)
    head_ref = "origin/#{pr_params.fetch(:head).fetch(:ref)}"
    base_ref = "origin/#{pr_params.fetch(:base).fetch(:ref)}"
    remote = git_repo.remotes.first
    git_repo.checkout(head_ref)
    ENV['PULL_REQUEST_ID'] = pr_params.fetch(:number).to_s
    Pronto.run(base_ref, path, formatter)
  end
end
