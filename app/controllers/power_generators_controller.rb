class PowerGeneratorsController < ApplicationController
  def index
    @power_generators = PowerGenerator.all
    @power_generators = if params[:format] == 'order_desc'
                          PowerGenerator.order(price: :desc)
                        elsif params[:format] == 'order_asc'
                          PowerGenerator.order(price: :asc)
                        elsif params[:format] == 'kwp_desc'
                          PowerGenerator.order(kwp: :desc)
                        else
                          PowerGenerator.order(kwp: :asc)
                        end
  end

  def show
    @power_generator = PowerGenerator.find(params[:id])
    @power_generator.add_cubed_weight if @power_generator.cubed_weight.nil?
  end

  def set_freight
    @power_generator = PowerGenerator.find(params[:id])
    response = Faraday.get "https://viacep.com.br/ws/#{params[:cep]}/json/"
    if response.status == 400
      flash.now[:alert] = "Insira um CEP válido. Formatos '00000000' ou 00000-000"
      return render :show
    end
    @address = JSON.parse(response.body, symbolize_names: true)
    if @power_generator.weight < @power_generator.cubed_weight
      @freight = Freight.find_by('state = ? AND (weight_min <= ? AND weight_max >= ?)',
                                 @address[:uf], @power_generator.weight, @power_generator.weight)
    else
      @freight = Freight.find_by('state = ? AND weight_min <= ? AND weight_max >= ?',
                                 @address[:uf], @power_generator.cubed_weight, @power_generator.cubed_weight)
    end
    @total_value = @power_generator.price + @freight.cost
    render :show
  end

  def recommend
    new_rec = Search.new(params[:price], params[:kwp],
                         params[:height], params[:width],
                         params[:lenght], params[:weight])
    @power_generators = new_rec.main_query
    @power_generators = new_rec.secondary_query if @power_generators.blank?

    render :index
  end
end
