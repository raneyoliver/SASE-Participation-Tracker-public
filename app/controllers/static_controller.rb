# Controller that renders index.html from static files
class StaticController < ApplicationController
  def index; end

  def view_events
    redirect_to '/view_events' and return unless helpers.check_auth

    render 'index'
  end
  
  def login
    redirect_to '/' and return if helpers.check_auth

    render 'index'
  end

  def authorized_index
    redirect_to '/login' and return unless helpers.check_auth

    render 'index'
  end

  def index_js
    render file: "#{Rails.root}/public/index.js"
  end
end
