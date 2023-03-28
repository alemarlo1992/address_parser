# Address Validator

## Prerequisite
1. `ruby 3.2.1`
2. git clone this repo

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



