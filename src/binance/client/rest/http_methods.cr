module Binance::HttpMethods
  {% for method in %w(get post delete) %}

    def public_{{method.id}}(url, params : HTTP::Params)
      headers = HTTP::Headers.new
      headers["Content-Type"] = "application/json"
      headers["Accept"] = "application/json"

      HTTP::Client.{{method.id}}("#{base_url}/#{url}?#{params}", headers)
    end

    def verified_{{method.id}}(url, params : HTTP::Params)
      raise "No API KEY assigned" if api_key.to_s.blank?

      headers = HTTP::Headers.new
      headers["Content-Type"] = "application/json"
      headers["Accept"] = "application/json"
      headers["X-MBX-APIKEY"] = api_key

      HTTP::Client.{{method.id}}("#{base_url}/#{url}?#{params}", headers)
    end

    def signed_{{method.id}}(url, params : HTTP::Params)
      raise "No API KEY assigned" if api_key.to_s.blank?
      raise "No API SECRET assigned" if secret_key.to_s.blank?

      headers = HTTP::Headers.new
      headers["Content-Type"] = "application/json"
      headers["Accept"] = "application/json"
      headers["X-MBX-APIKEY"] = api_key

      params["timestamp"] = Time.utc.to_unix_ms.to_s
      params["signature"] = hmac params.to_s

      HTTP::Client.{{method.id}}("#{base_url}/#{url}?#{params}", headers)
    end

  {% end %}
end
