require 'coinbase/wallet'
require 'em-http'
client = Coinbase::Wallet::AsyncClient.new(api_key: <api_key>, api_secret: <api secret>)
