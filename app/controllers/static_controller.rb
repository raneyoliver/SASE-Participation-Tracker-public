# Controller that renders index.html from static files
class StaticController < ApplicationController
  def index; end

  def authorized_index
    redirect_to '/login' and return unless helpers.check_auth

    render 'index'
  end

  def index_js
    render file: 'index.js'
  end
end
