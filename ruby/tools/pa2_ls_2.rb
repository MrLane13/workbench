#!/usr/bin/ruby
require 'find'

# Programming Assignment 2 - 'ls' Client
# Author - Lane Mills
# Date - 01 May 2017

# ** Methods **
def directory_hash(path, name=nil)
	data = {:data => [name || path]}
	data[:children] = children = []
	puts path+"/"
	Dir.foreach(path) do |entry|
		next if(entry == '..'|| entry =='.' || entry =='.git')
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

def print_dir(path)
	puts Dir[path+"/*"]
end

# ** Main code **

# Change to home directory (ruby likes to start from where it's run)
files = 0
dirs = 0
total = 0
Dir.chdir("/home/oscreader/")
# Welcome/instructions
puts "Enter a file or directory, or leave blank"
puts "OPTIONAL: add '-R' for recursive walk"
puts "Starting from '"+Dir.pwd+"/'"
# Take user input
start = gets
# Run method 'walk' with the user's input
if start.include?("-R")
	directory_hash(Dir.pwd+"/"+start.gsub(/(-R)|\s+|\n/,""))
else 
	print_dir(Dir.pwd+"/"+start.gsub(/(-R)|\s+|\n/,""))
end
puts "*****************"

