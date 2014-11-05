require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")

task :sample_data do
  
  # This is the data we will use for the book examples
  wally = User.create({
    :first_name => 'Wally',
    :last_name => 'Webcoder',
    :user_name => 'wally',
    :password => 'newpass1',
    :role_id => 2,
    :password_confirmation => 'newpass1',
    :email => 'wally@yahoo.com',
    :zip_code => '75024'
  })
  
  admin = User.create({
    :first_name => 'The',
    :last_name => 'Admin',
    :user_name => 'admin',
    :password => 'admin1',
    :role_id => 1,
    :password_confirmation => 'admin1',
    :email => 'bpoweski@yahoo.com',
    :zip_code => '75024'
  })  
  
  # venues
  mi_cocina = Venue.create({
    :name => "Mi Cocina",
    :address_one => "The Shops At Legacy",
    :address_two => "5760 Legacy Drive, Ste. B-1",    
    :zip_code => "75024",    
    :city => "Plano",
    :state => "TX"
  })
  %w(fajitas tacos margaritas flan).each { |t| mi_cocina.add_tag(t) }
  
  bobs = Venue.create({
    :name => "Bob's Steak & Chop House",
    :address_one => "The Shops At Legacy",
    :address_two => "5760 Legacy Drive, Ste. B-1",
    :zip_code => "75024",
    :city => "Plano",
    :state => "TX"
  })
  %w(martinis steak filet lobster).each { |t| bobs.add_tag(t) }
  
  # comments
  bobs.comments << Comment.new(
    :subject => 'Awesome!!!', 
    :body => "Make sure you try the cream corn.",
    :user => wally
  )
  
  bobs.comments << Comment.new(
    :subject => 'Fantastic!', 
    :body => "The steaks are fantastic and the martinis are dry!",
    :user => wally
  )
  
end

task :delete_sample_data do
  Venue.delete_all
  Comment.delete_all
  User.delete_all
  Tag.delete_all
  Tagging.delete_all
end