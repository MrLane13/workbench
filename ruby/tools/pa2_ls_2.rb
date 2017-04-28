#!/usr/bin/ruby
require 'find'

# Programming Assignment 1 - WHOIS Client
# Author - Lane Mills
# Date - 01 May 2017

# ** Methods **
def directory_hash(path, name=nil)
	data = {:data => [name || path]}
	data[:children] = children = []
	puts path+"/"
	Dir.foreach(path) do |entry|
		next if(entry == '..'|| entry =='.')
		full_path = File.join(path, entry)
		if File.directory?(full_path)
			children << directory_hash(full_path,entry)
		else
			children << entry
			puts entry.gsub(/\n|\r|/,"")
		end
	end
	return data
end

# ** Main code **

# Change to home directory (ruby likes to start from where it's run)
Dir.chdir("/home/oscreader/")
# Welcome/instructions
puts "Enter a file or directory, or leave blank"
puts "OPTIONAL: add '-R' for recursive walk"
puts "Starting from '"+Dir.pwd+"/'"
# Take user input
start = gets
# Run method 'walk' with the user's input
data_hash = directory_hash(Dir.pwd+"/"+start.gsub(/\n/,""))
puts "*****************"

