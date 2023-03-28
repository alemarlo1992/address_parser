# Address Validator

## Description 

Address validator is a script that parses through a file and validates an address. I used ruby `3.2.1` to implement this script. I have a file parser that parses through a list of addresses and then this parser calls an API class that is responsible for sending a request to Smarty Streets using the US Address Verification API. 

The API class creates the parameters needed for the GET and also handles the response. If a valid address is received it prints out the User Address and corrected address from Smarty Streets. In addition, it will also print out any invalid addresses. 

The API class is unit tested by mocking the expected body for each scenario. 

## Prerequisite
1. `ruby 3.2.1`
2. git clone `https://github.com/alemarlo1992/address_parser.git`

## API 

Endpoint: `https://us-street.api.smartystreets.com/street-address`

Licence: `us-core-cloud`

## Setting Up Environment Variables 

In your console

1. `export AUTH_ID=your-ID`
2. `export AUTH_TOKEN=your-token`

Test that you have ENV VARS
1. `echo $AUTH_ID` 
2. `echo $AUTH_TOKEN`   

## Running Script 

Example: 

`./valid_address_script.rb address.csv`

Use any file of choice but example here is `address.csv`

## Running Testing Suite 

`./api_test.rb`



