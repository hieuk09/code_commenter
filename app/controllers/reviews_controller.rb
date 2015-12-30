class ReviewsController < ApplicationController
  def create
    formatter = Pronto::Formatter::GithubPullRequestFormatter.new
    Pronto.run('origin/master', 'data/test-code-commenter', formatter)
    render json: {}, status: 200
  end
end
