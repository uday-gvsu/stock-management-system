json.call stock_detail, :id, :transaction_type, :quantity, :amount, :transaction_date, :stock_id, :created_at,
          :updated_at

json.stock do
  json.partial! 'stocks/stock', stock: stock_detail.stock
end

# json.url stock_detail_url(stock_detail, format: :json)
