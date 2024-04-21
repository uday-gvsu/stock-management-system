class StockDetailsController < ApplicationController
  before_action :set_stock_detail, only: %i[show update destroy]

  # GET /stock_details
  # GET /stock_details.json
  def index
    @stock_details = StockDetail.all
  end

  # GET /stock_details/1
  # GET /stock_details/1.json
  def show; end

  # POST /stock_details
  # POST /stock_details.json
  def create
    buy_stock_details = StockDetail.where(transaction_type: 'buy').map(&:quantity).reduce(0) {|a, b| a + b}
    sell_stock_details = StockDetail.where(transaction_type: 'sell').map(&:quantity).reduce(0) {|a, b| a + b}

    if (stock_detail_params[:transaction_type] == "sell")
      sell_stock_details += stock_detail_params[:quantity]
      if sell_stock_details > buy_stock_details
        render status: 400, json: { success: false, message: 'Cannot Sell Stock More than existing quantity' } and return
      end
    end
    @stock_detail = StockDetail.new(stock_detail_params)

    if @stock_detail.save
      render :show, status: :created, location: @stock_detail
    else
      render json: @stock_detail.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stock_details/1
  # PATCH/PUT /stock_details/1.json
  def update
    if @stock_detail.update(stock_detail_params)
      render :show, status: :ok, location: @stock_detail
    else
      render json: @stock_detail.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stock_details/1
  # DELETE /stock_details/1.json
  def destroy
    @stock_detail.destroy
  end

  def profit
    @total_units = 0
    @total_investment = 0
    @sold_amount = 0
    @current_amount = 0
    @profit = 0
    @bought_units = 0
    @sold_units = 0
    @stock_details = StockDetail.all

    @stock_details.each do |stock_detail|
      if stock_detail.transaction_type == 'buy'
        @total_investment += stock_detail.amount * stock_detail.quantity
        @bought_units += stock_detail.quantity
      else
        @sold_amount += stock_detail.amount * stock_detail.quantity
        @sold_units += stock_detail.quantity
      end
      @total_units += stock_detail.quantity
    end
    @current_amount = @stock_details.present? ? (@bought_units - @sold_units) * @stock_details.last.amount : 0
    @profit = @sold_amount - @total_investment
  end

  def stock_profit
    stocks = Stock.all
    @stock_profit = []

    stocks.each do |stock|
      total_units = 0
      total_investment = 0
      sold_amount = 0
      current_amount = 0
      profit = 0
      bought_units = 0
      sold_units = 0
      stock_details = stock.stock_details

      stock_details.each do |stock_detail|
        if stock_detail.transaction_type == 'buy'
          total_investment += stock_detail.amount * stock_detail.quantity
          bought_units += stock_detail.quantity
        else
          sold_amount += stock_detail.amount * stock_detail.quantity
          sold_units += stock_detail.quantity
        end
        total_units += stock_detail.quantity
      end

      current_amount = stock_details.present? ? (bought_units - sold_units) * stock_details.last.amount : 0
      profit = sold_amount - total_investment
      @stock_profit.push({
                         total_units: total_units,
                         total_investment: total_investment,
                         sold_amount: sold_amount,
                         current_amount: current_amount,
                         profit: profit,
                         stock_name: stock.name
                        })
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_stock_detail
    @stock_detail = StockDetail.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def stock_detail_params
    params.require(:stock_detail).permit(:transaction_type, :quantity, :amount, :transaction_date, :stock_id)
  end
end
