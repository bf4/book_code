#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'RMagick'

class Image < ActiveRecord::Base
  
  DIRECTORY = 'public/uploaded_images'
  THUMB_MAX_SIZE = [125,125]
  
  after_save :process
  after_destroy :cleanup
  
  def file_data=(file_data)
    @file_data = file_data
    write_attribute 'extension',
                    file_data.original_filename.split('.').last.downcase
  end
  
  def url
    path.sub(/^public/,'')
  end
  
  def thumbnail_url
    thumbnail_path.sub(/^public/,'')
  end
  
  def path
    File.join(DIRECTORY, "#{self.id}-full.#{extension}")
  end
  
  def thumbnail_path
    File.join(DIRECTORY, "#{self.id}-thumb.#{extension}")
  end
  
  #######
  private
  #######
	
  def process
    if @file_data
      create_directory
      cleanup
      save_fullsize
      create_thumbnail
      @file_data = nil
    end
  end
  
  def save_fullsize
    File.open(path,'wb') do |file|
      file.write @file_data.read
    end
  end
  
  def create_thumbnail
    img = Magick::Image.read(path).first
    thumbnail = img.thumbnail(*THUMB_MAX_SIZE)
    thumbnail.write thumbnail_path	  
  end
  
  def create_directory
    FileUtils.mkdir_p DIRECTORY
  end
  
  def cleanup
    Dir[File.join(DIRECTORY, "#{self.id}-*")].each do |filename|
      File.unlink(filename) rescue nil
    end
  end
  
end
