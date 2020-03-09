class PowerGeneratorsController < ApplicationController
  def index
    @power_generators = PowerGenerator.all.page params[:page]
    @power_generators = if params[:format] == 'order_desc'
                          PowerGenerator.order(price: :desc).page params[:page]
                        elsif params[:format] == 'order_asc'
                          PowerGenerator.order(price: :asc).page params[:page]
                        elsif params[:format] == 'kwp_desc'
                          PowerGenerator.order(kwp: :desc).page params[:page]
                        else
                          PowerGenerator.order(kwp: :asc).page params[:page]
                        end
  end

  def show
    @power_generator = PowerGenerator.find(params[:id])
    @power_generator.add_cubed_weight if @power_generator.cubed_weight.nil?
  end

  def set_freight
    @power_generator = PowerGenerator.find(params[:id])
    @address = get_address(params[:cep])
    return render :show if @address.nil?

    @freight = Freight.new.freight_cost(@address, @power_generator)
    @total_value = @power_generator.price + @freight.cost
    render :show
  end

  def get_address(cep)
    response = Faraday.get "https://viacep.com.br/ws/#{cep}/json/"
    if response.status == 400
      flash.now[:alert] = "Insira um CEP válido. Ex: '00000000' ou 00000-000"

      return nil
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def recommend
    if !params[:price].nil? && !params[:kwp].nil?
      flash.now[:alert] = "Preencha pelo menos um dos campos"

      index
    end
    new_rec = Search.new(params[:price], params[:kwp])
    @power_generators = new_rec.main_query
    @power_generators = new_rec.secondary_query if @power_generators.blank?
    @power_generators
    render :index
  end
end
