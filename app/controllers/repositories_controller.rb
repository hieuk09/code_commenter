class RepositoriesController < ApplicationController
  before_action :set_repository, only: [:show, :edit, :update, :destroy]

  # GET /repositories
  def index
    @repositories = Repository.all
  end

  # GET /repositories/1
  def show
  end

  # GET /repositories/new
  def new
    @repository = Repository.new
  end

  # GET /repositories/1/edit
  def edit
  end

  # POST /repositories
  def create
    repository_params = params.fetch(:repository)
    link = repository_params.fetch(:link)
    name = link.gsub(/https:\/\/github\.com\//, '')
    path = File.join('data', name)
    @repository = Repository.new( path: path, name: name, link: link)

    if @repository.save
      credentials = Rugged::Credentials::UserPassword.new(
        username: Rails.application.secrets.github_access_account,
        password: Rails.application.secrets.github_access_token
      )
      Rugged::Repository.clone_at(link, path, { credentials: credentials })
      client = Octokit::Client.new(
        login: Rails.application.secrets.github_access_account,
        password: Rails.application.secrets.github_access_token
      )

      data = client.create_hook(name, 'web', {
        url: Rails.application.secrets.webhook_api,
        content_type: 'json'
      }, {
        events: ['pull_request'],
        active: true
      })
      @repository.hook_id = data['id']
      @repository.save
      redirect_to @repository, notice: 'Repository was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /repositories/1
  def update
    if @repository.update(repository_params)
      redirect_to @repository, notice: 'Repository was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /repositories/1
  def destroy
    if Repositories::Destroy.execute(@repository)
      redirect_to repositories_url, notice: 'Repository was successfully destroyed.'
    else
      redirect_to repositories_url, notice: 'Can not destroy this repository'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repository
      @repository = Repository.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def repository_params
      params[:repository].permit(:name, :path, :link)
    end
end
