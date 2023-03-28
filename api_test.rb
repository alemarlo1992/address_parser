#!/usr/bin/env ruby
require 'test/unit'

require_relative "api"
include Api

class ApiTest < Test::Unit::TestCase
  def test_invalid_address
    street = 'Fake Street'
    city = 'Fake City'
    zipcode = '00000'

    expected_body = [].to_json

    address_validator_object = Api::AddressValidator.new(street, city, zipcode)
    result = address_validator_object.user_message(expected_body)

    assert_equal(result, "Fake Street, Fake City, 00000 -> Invalid Address")          
  end

  def test_valid_addess
    street = '100 van ness ave'
    city = 'San Francisco'
    zipcode = '94102'

    expected_body = [
      {
          "input_index": 0,
          "candidate_index": 0,
          "delivery_line_1": "100 Van Ness Ave",
          "last_line": "San Francisco CA 94102-5209",
          "delivery_point_barcode": "941025209990",
          "components": {
              "primary_number": "100",
              "street_name": "Van Ness",
              "street_suffix": "Ave",
              "city_name": "San Francisco",
              "default_city_name": "San Francisco",
              "state_abbreviation": "CA",
              "zipcode": "94102",
              "plus4_code": "5209",
              "delivery_point": "99",
              "delivery_point_check_digit": "0"
          },
          "metadata": {
              "record_type": "H",
              "zip_type": "Standard",
              "county_fips": "06075",
              "county_name": "San Francisco",
              "carrier_route": "C024",
              "congressional_district": "11",
              "building_default_indicator": "Y",
              "rdi": "Residential",
              "elot_sequence": "0121",
              "elot_sort": "A",
              "latitude": 37.7764,
              "longitude": -122.41929,
              "precision": "Zip9",
              "time_zone": "Pacific",
              "utc_offset": -8,
              "dst": true
          },
          "analysis": {
              "dpv_match_code": "D",
              "dpv_footnotes": "AAN1",
              "dpv_cmra": "N",
              "dpv_vacant": "N",
              "dpv_no_stat": "Y",
              "active": "Y",
              "footnotes": "H#B#",
              "enhanced_match": "postal-match,missing-secondary"
          }
      }
    ].to_json

    address_validator_object = Api::AddressValidator.new(street, city, zipcode)
    result = address_validator_object.user_message(expected_body)

    assert_equal(result, "100 van ness ave, San Francisco, 94102 -> 100 Van Ness Ave, San Francisco, 94102-5209")          
  end
end