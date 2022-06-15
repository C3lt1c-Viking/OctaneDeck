require 'coinbase/exchange'
require 'eventmachine'

rest_api = Coinbase::Exchange::AsyncClient.new(Coinbase_api_key, Coinbase_api_secret, Coinbase_api_pass)
EM.run {
  EM.add_periodic_timer(10) {
    rest_api.last_trade(product_id: "BTC-GBP") do |resp|
      p "Spot Rate: £ %.2f" % resp.price
    end
  }
}
