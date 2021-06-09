require 'open-uri'
require 'nokogiri'

def handle_string_io_as_file(io, filename)
  return io unless io.class == StringIO
  file = Tempfile.new(["temp",".png"], encoding: 'ascii-8bit')
  file.binmode
  file.write io.read
  file.open
end

puts "Deleting current items..."

Park.destroy_all
User.destroy_all
Category.destroy_all
Bookmark.destroy_all
ParkCategory.destroy_all
Vote.destroy_all
Review.destroy_all

puts "Creating users..."

User.create(email: 'cristina@example.com', password: '123456', first_name: 'Cristina', last_name: 'Salazar')
User.create(email: 'mikael@example.com', password: '123456', first_name: 'Mikael', last_name: 'Svensson')
User.create(email: 'joe@example.com', password: '123456', first_name: 'Joe', last_name: 'Rohde')

puts "Loading from CSV..."

csv_file = File.join(__dir__, 'parks.csv')

csv_data = CSV.read('parks.csv')
csv_data.each do |row|
  park = Park.create(name: row[0], address: row[0], region: row[1], details: row[2], key: row[3])
end

puts "Seeding categories..."

Category.create(name: 'parking', emoji: 'parking')
Category.create(name: 'toilets', emoji: 'toilet')
Category.create(name: 'skating', emoji: 'skating')
Category.create(name: 'suitable for babies and toddlers', emoji: 'baby')
Category.create(name: 'suitable for kids', emoji: 'child')
Category.create(name: 'picnic', emoji: 'shopping-basket')
Category.create(name: 'grill', emoji: 'hamburger')
Category.create(name: 'swimming', emoji: 'swimming-pool')
Category.create(name: 'outdoor gym', emoji: 'dumbbell')
Category.create(name: 'pet-friendly', emoji: 'paw')
Category.create(name: 'drinking allowed', emoji: 'beer')
Category.create(name: 'running', emoji: 'running')

puts "Almost there..."

Park.all.each do |park|
  Category.all.each do |category|
    ParkCategory.create(category_id: category.id, park_id: park.id)
  end
end

puts "Done!"

# Code we don't need anymore but nice to keep

# Scraping from web to CSV

# img_prefix = "https://parker.stockholm"
# url = "https://parker.stockholm/parker/"
# html_file = URI.open(url).read
# html_doc = Nokogiri::HTML(html_file)

# regions = []
# regions_two = []
# data = []

# html_doc.search('.accordion-item__title').each do |element|
#   regions << element.text.strip
# end

# html_doc.search('.accordion-item__title, .arrow-link').each do |element|
#   data << element.text.strip
# end

# data.slice(0..data.count - 11).each do |name|
#   if regions.include?(name)
#     regions_two << name
#   else
#     park_url = "#{url}#{name.parameterize}"
#     park_html_file = URI.open(park_url).read
#     park_html_doc = Nokogiri::HTML(park_html_file)
#     region = regions_two.last
#     details = park_html_doc.search('p')[2].text
#     img_suffix = park_html_doc.search('figure').search('img').attribute("src").value.strip
#     img_url = "#{img_prefix}#{img_suffix}"
#     CSV.open('parks.csv', "ab") do |csv|
#       csv << [name, region, details, img_url]
#     end
#     park = Park.new(name: name, address: name, region: region, details: details)
#     file = URI.open(img_url)
#     park.photos.attach(io: handle_string_io_as_file(file, 'image.png'), filename: 'park.png', content_type: 'image/png')
#     park.save
#   end
# end

# Original park seeds

# park = Park.new(name: "Rålambshovsparken", address: 'Rålambshovsparken', region: 'Kungsholmen', details: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
# file = URI.open('https://upload.wikimedia.org/wikipedia/commons/9/9a/R%C3%A5lambshovsparken_syd_2010.jpg')
# park.photos.attach(io: handle_string_io_as_file(file, 'image.png'), filename: 'park.png', content_type: 'image/png')
# park.save

# park_two = Park.new(name: "Tantolunden", address: 'Tantolunden', region: 'Södermalm', details: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
# file = URI.open('https://www.matochresebloggen.se/wp-content/uploads/2015/08/IMG_8178.jpg')
# park_two.photos.attach(io: handle_string_io_as_file(file, 'image.png'), filename: 'park_two.png', content_type: 'image/png')
# park_two.save

# park_four = Park.new(name: "Vasaparken", address: 'Vasaparken', region: 'Norrmalm', details: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
# file = URI.open('http://www.noje.se/uploads/articles/7d51a276bde29a2b7b5f14b661f2df1a.jpg')
# park_four.photos.attach(io: handle_string_io_as_file(file, 'image.png'), filename: 'park_four.png', content_type: 'image/png')
# park_four.save
