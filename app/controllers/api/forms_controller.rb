# Controller for api functionality related to forms
class Api::FormsController < ApplicationController
  def show
    @form = Form.find(params[:id])

    if @form.time_restricted == true && !helpers.is_valid(@form)
      head :forbidden and return
    end

    @serialized_form = helpers.serialize_form @form
    render json: @serialized_form
    
    rescue ActiveRecord::RecordNotFound
      head :not_found and return
    end
end
