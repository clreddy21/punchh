class HomeController < ApplicationController
  def index
    @currencies = Currency.list
  end

  def convert
    @result = Currency.get_data(params)
    render json: @result
  end
end
