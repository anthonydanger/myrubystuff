# event_manager3

# Dependencies
require 'csv'
require 'sunlight'
require 'erb'

Sunlight::Base.api_key = "e179a6973728c4dd3fb1204283aaccb5"

# Definitions

	def clean_zipcodes(zipcode)
		zipcode.to_s.rjust(5,"0")[0..4]
	end

	def legislators_for_zipcode(zipcode)
		Sunlight::Legislator.all_in_zipcode(zipcode)
	end

	def save_thank_you_letters(id,form_letter)
	    Dir.mkdir("output") unless Dir.exists?("output")

	  	filename = "output/thanks_#{id}.html"

	 	 File.open(filename,'w') do |file|
	 	 	file.puts form_letter
	 	end
	end

	def clean_phone_numbers(original)
	original.each do |line|
		number = line[:homephone]
		clean_number = number.delete(".()' '-")
		if clean_number.length == 10
			clean_number
		elsif clean_number.length == 11
			if clean_number[0] == "1"
			clean_number = clean_number[1..-1]
			else
				clean_number = "0000000000"
			end
		else	
			clean_number = "0000000000"
		end

		return clean_number
	end

	def rank_times
		hours = Array.new(24){0}
		contents.each do |line|
			hour = line[:regdate].split(" ")[1]
			hour = hour.split(":")[0]
			hours[hour.to_i] = hours[hour.to_i] + 1
		end
		
		hours.each_with_index{|counter,hour| puts "#{hour}\t#{counter}"}
	end

	def day_stats
		days = Array.new(7){0}
		contents.each do |line|
			date = line[:regdate].split(" ")[0]
			date = Date.strptime("#{date}", "%m/%d/%y")
			date = date.wday
			days[date] = days[date] + 1		
		end
		days.each_with_index{|counter,date| puts "#{date}\t #{counter}"}
	end



puts "EventManager Initialized!"

@contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

@contents.each do |row|
	id = row[0]
	first_name =  row[:first_name]
	zipcode = clean_zipcodes(row[:zipcode])
	phone_numbers = clean_phone_numbers(row[:homephone])
	legislators = legislators_for_zipcode(zipcode)
	form_letter = erb_template.result(binding)
	save_thank_you_letters(id,form_letter)
	end
end
