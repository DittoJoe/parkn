require 'open-uri'
def handle_string_io_as_file(io, filename)
  return io unless io.class == StringIO
  file = Tempfile.new(["temp",".png"], encoding: 'ascii-8bit')
  file.binmode
  file.write io.read
  file.open
end

Park.destroy_all
User.destroy_all

cristina = User.create(email: 'cristina@example.com', password: '123456', first_name: 'Cristina', last_name: 'Salazar')
mikael = User.create(email: 'mikael@example.com', password: '123456', first_name: 'Mikael', last_name: 'Svensson')
joe = User.create(email: 'joe@example.com', password: '123456', first_name: 'Joe', last_name: 'Rohde')

park = Park.new(name: "Rålambshovsparken", address: 'Rålambshovsparken', region: 'Kungsholmen')
file = URI.open('https://upload.wikimedia.org/wikipedia/commons/9/9a/R%C3%A5lambshovsparken_syd_2010.jpg')
park.photo.attach(io: handle_string_io_as_file(file, 'image.png'), filename: 'park.png', content_type: 'image/png')
park.save

park_two = Park.new(name: "Tantolunden", address: 'Tantolunden', region: 'Södermalm')
file = URI.open('https://www.matochresebloggen.se/wp-content/uploads/2015/08/IMG_8178.jpg')
park.photo.attach(io: handle_string_io_as_file(file, 'image.png'), filename: 'park_two.png', content_type: 'image/png')
park_two.save

park_three = Park.new(name: "Humlegården", address: 'Humlegården', region: 'Östermalm')
file = URI.open('https://parker.stockholm/siteassets/parker-och-natur/parker/humlegarden/humlegarden-2017.jpg')
park.photo.attach(io: handle_string_io_as_file(file, 'image.png'), filename: 'park_three.png', content_type: 'image/png')
park_three.save

park_four = Park.new(name: "Vasaparken", address: 'Vasaparken', region: 'Vasastan')
file = URI.open('http://www.noje.se/uploads/articles/7d51a276bde29a2b7b5f14b661f2df1a.jpg')
park.photo.attach(io: handle_string_io_as_file(file, 'image.png'), filename: 'park_four.png', content_type: 'image/png')
park_four.save
