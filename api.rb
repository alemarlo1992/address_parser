require 'uri'
require 'net/http'
require 'json'

module Api
  class AddressValidator
    def initialize(street, city, zipcode)
      @street ||= street
      @city ||= city
      @zipcode ||= zipcode
    end

    def call
      validation
    end

    def validation
      params = uri_params

      uri = URI('https://us-street.api.smartystreets.com/street-address')

      uri.query = URI.encode_www_form(params)

      response = Net::HTTP.get_response(uri)

      handle_response(response)
    end

    def handle_response(response)
      case response
      when Net::HTTPSuccess
        user_message(response.body)
      when Net::HTTPUnauthorized
        {'error' => "#{response.message}: username and password set and correct?"}
      when Net::HTTPServerError
        {'error' => "#{response.message}: try again later?"}
      else
        {'error' => response.message}
      end
    end

    def user_message(response_body)
      data = JSON.parse(response_body)

      if !data.empty?
        updated_address = updated_address(data: data)
        puts "#{user_address} -> #{updated_address}"
        "#{user_address} -> #{updated_address}"
      else
        puts "#{user_address} -> Invalid Address"
        "#{user_address} -> Invalid Address"
      end
    end

    def user_address 
      "#{@street}, #{@city}, #{@zipcode}"
    end

    def updated_address(data:)
      corrected_street = data[0]["delivery_line_1"]
      corrected_city = data[0]["components"]["city_name"]
      corrected_zipcode = data[0]["components"]["zipcode"]
      last_four_zipcode = data[0]["components"]["plus4_code"]

      "#{corrected_street}, #{corrected_city}, #{corrected_zipcode}-#{last_four_zipcode}"
    end 

    def uri_params
      auth_id = ENV['AUTH_ID']
      auth_token = ENV['AUTH_TOKEN']
      licence = "us-core-cloud"

      { :"auth-token" => auth_token, :"auth-id" => auth_id, :licence => licence, :street => @street, :city => @city, :zipcode => @zipcode }
    end
  end
end
