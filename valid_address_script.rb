#!/usr/bin/env ruby

require_relative "file_parser"
include FileParser

file_name = ARGV[0]

file_parser(file_name)
