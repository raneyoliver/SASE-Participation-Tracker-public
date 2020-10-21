# Controller for api functionality related to forms
class Api::FormsController < ApplicationController
  before_action :validate

  def show
    @form = Form.find(params[:id])
    @serialized_form = helpers.serialize_form @form
    render json: @serialized_form
  end

  def validate
    @form = Form.find(params[:id])
    redirect_to '/form/unavailable', status: :forbidden and return unless helpers.form_valid?(@form)
  rescue ActiveRecord::RecordNotFound
    head :not_found and return
  end
end
