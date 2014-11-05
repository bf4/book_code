#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
class ProjectSeeder

  def self.run(*args)
    new(*args).run
  end
  
  def initialize(project, file_prefix, designer)
    @project = project
    @file_prefix = file_prefix
    @designer = designer
  end

  def run
    @designer.projects << @project
    files.each do |filename|
      basename = File.basename(filename, '.png')
      parts = basename.split('-')
      title = parts.last.titleize
      file = File.open(filename)
      @project.creations.create!(name: title,
                                 file: file,
                                 stage: 'new',
                                 revision: 1,
                                 hours: rand(30),
                                 description: "#{@project.name} file",
                                 designer: @designer)
    end
  end

  def files
    @files ||= Dir.glob(File.join(seed_directory, "#{@file_prefix}-*"))
  end

  def seed_directory
    @seed_directory ||= File.join(Rails.root, 'db', 'seeds', 'creations')
  end
  
end
