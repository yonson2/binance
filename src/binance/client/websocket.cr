require "./websocket/responses/*"

module Binance
  class Websocket

    property api_key : String
    property secret_key : String

    def initialize(api_key = "", secret_key = "")
      @api_key = api_key
      @secret_key = secret_key
    end

  end
end
