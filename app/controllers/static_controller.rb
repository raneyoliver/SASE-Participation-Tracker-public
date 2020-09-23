# Controller that renders index.html from static files
class StaticController < ApplicationController
  def index; end
  def authorized_index
    helpers.get_auth
    render 'index'
  end  
end
