require 'nokogiri'
require 'open-uri'

def slack(content)
  `curl -X POST -H 'Content-type: application/json' --data '{"text":"#{content}"}' https://hooks.slack.com/services/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`
end

doc = Nokogiri::HTML(open('https://www.apple.com/jp/shop/refurbished/mac'))

contents = doc.css('ul li').map do |node|
  node.inner_text.gsub(/\s+/, ' ')
end

contents.select! do |content|
  content.match(/\[整備済製品\]/)
end

# slack(contents.length)

old_contents = []

File.open('list.txt') do |f|

  f.each_line do |line|
    old_contents << line.chomp
  end

end

contents.each do |content|

  if not old_contents.include?(content)
    slack('New item added!\n' + content)
  end

end

old_contents.each do |content|

  if not contents.include?(content)
    slack('Following item sold.\n' + content)
  end

end

File.open('list.txt', 'w') do |f|

  contents.each do |content|
    f.puts(content)
  end

end
