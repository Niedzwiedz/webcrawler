require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'fileutils'

PAGE_URL = "http://ruby.bastardsbook.com/files/hello-webpage.html"
list=[]

puts "What page to start?"
url = gets.chomp
list.push(url)
puts "Loading"
pagenum=0
wholearray=File.open("data/everything.txt", "w")

list.each do |ele|
	begin
		page = Nokogiri::HTML(open(ele))
		num=page.css('a').length
		pagenum+=1
		linkfile=File.open("data/#{pagenum}.txt", 'w')
		
		i=0
		while i<num
	
			#przypisanie oraz wyswietlanie i-tego linka
			actualLink=page.css('a')[i]['href']
			if actualLink.length===0
				raise "?"
			else
				aLnum=actualLink.length
			end
			j=0
			k=0
			#Sprawdzanie czy zawiera jest zewnetrzny
			if (actualLink.include? "http://") || (actualLink.include? "https://")
				#czyszczenie linka
				while j<aLnum
					if actualLink[j] === "/"
						k+=1
					end
					if ((k === 3) || (actualLink[j] === "?"))
						actualLink=actualLink[0,j]
						j+=1
					else
						j+=1
					end		
				end
				#usun www.
				if actualLink.include? "www."
					actualLink.gsub! "www.", ""
				end
				#sprawdzenie czy nie ma go w tablicy
				if !(list.include? actualLink)
					list.push(actualLink)
					
					linkfile.puts ele + "#=>" + actualLink
					wholearray.puts ele+ "$=>" + actualLink
				end
			end
	
			#iteracja - zeby przejsc do nastepnego linka
			i+=1
		end
		puts ele
		linkfile.close

	rescue
		puts "Brak liknow"
	end
end
wholearray.close
