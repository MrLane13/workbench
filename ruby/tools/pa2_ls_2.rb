#!/usr/bin/ruby
require 'find'

# Programming Assignment 2 - 'ls' Client
# Author - Lane Mills
# Date - 01 May 2017

# ** Methods **

# Recursive travers, build hash.
# A hash seemed like the nicest way to get the desired output format.
def directory_hash(apath, name=nil)
	path = apath.gsub(/(-R)|\s+|\n/,"")
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
	rescue 
		puts "ERROR : could not traverse path: "+path
end

# Traverse current directory
def print_dir(apath)
	path = apath.gsub(/(-R)|\s+|\n/,"")
	puts Dir[path+"/*"]
	return Dir[path+"/*"]
end
# Count files recursively
def loop_count_file(apath)
	path = apath.gsub(/(-R)|\s+|\n/,"")
	return Dir.glob(File.join(path,'**','*'))
					.select {|file| File.file?(file)}.count
end
# Count directories recursively
def loop_count_dirs(apath)
	path = apath.gsub(/(-R)|\s+|\n/,"")
	return Dir.glob(File.join(path,'**','*'))
					.select {|dir| File.directory?(dir)}.count
end

# ** Main code **

# Change to home directory (ruby likes to start from where it's run)
dir = Dir[]
file_count = 0
dir_count = 0
total_count = 0
Dir.chdir("/home/oscreader/")
# Welcome/instructions
puts "*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*"
puts "*********************************************"
puts "Enter a file or directory, or leave blank"
puts "OPTIONAL: add '-R' for recursive walk"
puts "Starting from '"+Dir.pwd+"/'"
# Take user input
start = gets
puts "***********FILES AND DIRECTORIES**************"
# Check user input for '-R'
if start.include?("-R")
	directory_hash(Dir.pwd+"/"+start)
	puts "Loading..."
	file_count = loop_count_file(start)
	dir_count = loop_count_dirs(start)
else 
	dir = print_dir(Dir.pwd+"/"+start)
	dir.each {|val| if File.directory?(val) 
				then 
					dir_count=dir_count+1
				else 
					file_count=file_count+1 
				end}
end
total_count = file_count+dir_count
puts "*****************SUMMARY*********************"
# Summaries
puts "Files: "+file_count.to_s
puts "Dirs : "+dir_count.to_s
puts "Total: "+total_count.to_s
puts "*********************************************"
puts "*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*"
