# Controller for api functionality related to forms
class Api::FormsController < ApplicationController
  def show
    @form = Form.find(params[:id])
    render json: @form, include: { event: { only: :name } }, except: [:start_time, :end_time]
  rescue ActiveRecord::RecordNotFound
    head :not_found and return
  end
end
