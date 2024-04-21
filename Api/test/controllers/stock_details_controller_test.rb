require "test_helper"

class StockDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stock_detail = stock_details(:one)
  end

  test "should get index" do
    get stock_details_url, as: :json
    assert_response :success
  end

  test "should create stock_detail" do
    assert_difference("StockDetail.count") do
      post stock_details_url, params: { stock_detail: { amount: @stock_detail.amount, quantity: @stock_detail.quantity, stock_id: @stock_detail.stock_id, transaction_date: @stock_detail.transaction_date, transaction_type: @stock_detail.transaction_type } }, as: :json
    end

    assert_response :created
  end

  test "should show stock_detail" do
    get stock_detail_url(@stock_detail), as: :json
    assert_response :success
  end

  test "should update stock_detail" do
    patch stock_detail_url(@stock_detail), params: { stock_detail: { amount: @stock_detail.amount, quantity: @stock_detail.quantity, stock_id: @stock_detail.stock_id, transaction_date: @stock_detail.transaction_date, transaction_type: @stock_detail.transaction_type } }, as: :json
    assert_response :success
  end

  test "should destroy stock_detail" do
    assert_difference("StockDetail.count", -1) do
      delete stock_detail_url(@stock_detail), as: :json
    end

    assert_response :no_content
  end
end
