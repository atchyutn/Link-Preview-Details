require 'nokogiri'
require 'open-uri'

puts "Please enter the url you want to find preview"
url = gets.chomp
doc = Nokogiri::HTML(open(url), nil, 'UTF-8')

title = ""
description = ""
url = ""
image_url = ""

doc.xpath("//head//meta").each do |meta|
    if meta['property'] == 'og:title'
        title = meta['content']
		puts "\n\n TITLE: #{title}\n\n"
    elsif meta['property'] == 'og:description' || meta['name'] == 'description'
        description = meta['content']
				puts "\n\n DESCRIPTION: #{description}\n\n"
    elsif meta['property'] == 'og:url'
        url = meta['content']
	puts url
    elsif meta['property'] == 'og:image'
        image_url = meta['content']
				puts "\n\nmIMAGE: #{image_url}\n\n"
    end
end

if title == ""
    title_node = doc.at_xpath("//head//title")
    if title_node
        title = title_node.text
	puts "\n\n TITLE: #{title}\n\n"
    elsif doc.title
        title = doc.title
    else
        title = param_url
    end
end

if description ==""
    #maybe search for content from BODY
    description = title
    puts "\n\n DESCRIPTION: #{description}\n\n"
end

if image_url == ""
	image_url = doc.at_css('img').attr('src')
	puts "\n\nIMAGE:#{image_url}\n\n"
end

#if url ==""
#    url = param_url
#end

#render :json => {:title => title, :description => description, :url => url, :image_url => image_url} and return



