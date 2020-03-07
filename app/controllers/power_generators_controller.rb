class PowerGeneratorsController < ApplicationController
  def index
    @power_generators = PowerGenerator.all
  end

  def recommend
    recommendation = Recommend.new(params[:price], params[:kwp],
                                   params[:height], params[:width],
                                   params[:lenght], params[:weight])
    @power_generators = recommendation.main_query
    if @power_generators.blank? 
      @power_generators = recommendation.secondary_query
    end  
    render :index
  end
end
