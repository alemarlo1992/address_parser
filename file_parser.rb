require_relative "api"
include Api
module FileParser
  def file_parser(file_name)
    File.readlines(file_name).drop(1).each do |line|
        street, city, zipcode = line.strip.split(',')
        Api::AddressValidator.new(street, city, zipcode).call
    end 
  end
end