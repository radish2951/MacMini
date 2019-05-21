require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open('https://www.apple.com/jp/shop/refurbished/mac'))

contents = doc.css('ul li').map do |node|
  node.inner_text
end

i3 = contents.select { |content| content.match?(/mini[\S\s]*(クアッド|6)コア[\S\s]*i(3|5)/i) }

i3.each do |content|
  `curl -X POST -H 'Content-type: application/json' --data '{"text":"#{content}"}' https://hooks.slack.com/services/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`
end
