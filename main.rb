require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open('https://www.apple.com/jp/shop/refurbished/mac'))

contents = doc.css('ul li').map do |node|
  node.inner_text
end

i3 = contents.select { |content| content.match?(/Core i3/) }
