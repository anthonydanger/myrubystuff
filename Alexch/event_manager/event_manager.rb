# event_manager2.rb

# Dependencies
require 'sunlight'
require "csv"

# Class Definition
class EventManager
	INVALID_ZIPCODE = "00000"
	INVALID_PHONE_NUMBER = "0000000000"
	Sunlight::Base.api_key = "e179a6973728c4dd3fb1204283aaccb5"


	def initialize(filename)
		puts "EventManager Initialized."
		@file = CSV.open(filename, {headers: true, header_converters: :symbol})
	end

	def print_names
		@file.each do |line|
			puts "#{line[:first_name]} #{line[:last_name]}"
		end
	end

	def print_zipcodes
		@file.each do |line|
			zipcodes = clean_zipcode(line[:zipcode])
			puts zipcodes.to_s
		end
	end

	def clean_zipcode(zipcode)
		zipcode.nil? ? INVALID_ZIPCODE : zipcode.to_s.rjust(5, "0")
	end

	def print_numbers
		@file.each do |line|
			number = clean_numbers(line[:homephone])
			puts number
		end
	end

	def clean_numbers(original)
		@file.each do |line|
			number = line[:homephone]
			clean_number = number.delete(".()' '-")
			if clean_number.length == 10
				clean_number
			elsif clean_number.length == 11
				if clean_number[0] == "1"
				clean_number = clean_number[1..-1]
				else
					clean_number = INVALID_PHONE_NUMBER
				end
			else	
				clean_number = INVALID_PHONE_NUMBER
			end

			return clean_number
		end
	end

	def rep_lookup(zipcode)
		Sunlight::Legislator.all_in_zipcode(zipcode).collect do |legislator|
      	"#{legislator.title}. #{legislator.firstname[0]}. #{legislator.lastname} (#{legislator.party})"
    	end
    end

	def create_form_letters
		letter = File.open("form_letter.html", "r").read
		20.times do
			line = @file.readline

			custom_letter = letter.gsub("#first_name", line[:first_name].to_s)
			custom_letter = custom_letter.gsub("#last_name", line[:last_name].to_s)
			custom_letter = custom_letter.gsub("#street", line[:street].to_s)
			custom_letter = custom_letter.gsub("#city", line[:street].to_s)
			custom_letter = custom_letter.gsub("#state", line[:state].to_s)
			custom_letter = custom_letter.gsub("#zipcode", line[:zipcode].to_s)
		end
	end

	def rank_times
		hours = Array.new(24){0}
		@file.each do |line|
			hour = line[:regdate].split(" ")[1]
			hour = hour.split(":")[0]
			hours[hour.to_i] = hours[hour.to_i] + 1
		end
		
		hours.each_with_index{|counter,hour| puts "#{hour}\t#{counter}"}
	end

	def day_stats
		days = Array.new(7){0}
		@file.each do |line|
			date = line[:regdate].split(" ")[0]
			date = Date.strptime("#{date}", "%m/%d/%y")
			date = date.wday
			days[date] = days[date] + 1		
		end
		days.each_with_index{|counter,date| puts "#{date}\t #{counter}"}
	end

	def state_stats
		state_data = Hash.new
		
		@file.each do |line|

			if state_data.has_key?(line[:state])
				state_data[line[:state]] += 1
			else
				state_data[line[:state]] = 1
 			end

			state_data = state_data.select{|state, counter| state}.sort_by{|state, counter| state unless state.nil?}
			state_data.each do |state, counter|
				puts "#{state}: #{counter}"
			end
		end
	end
 
	def output_data
		output = CSV.open("event_attendees_clean.csv", "w")
		@file.each do |line|
			if @file.lineno == 2
				output << line.headers
			end
			line[:homephone] = clean_numbers(line[:homephone])
			line[:zipcode] = clean_zipcode(line[:zipcode])
			output << line
		end
	end

end



# Script
manager = EventManager.new("event_attendees_clean.csv")
manager.state_stats