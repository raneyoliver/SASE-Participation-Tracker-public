# Controller that renders index.html from static files
class StaticController < ApplicationController
  def index; end

  def authorized_index
    helpers.check_auth
    render 'index'
  end
end
