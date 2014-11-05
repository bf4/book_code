#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module FileCreation
  OLDFILE = "old"
  NEWFILE = "new"

  def create_timed_files(oldfile, *newfiles)
    return if (File.exist?(oldfile) &&
      newfiles.all? { |newfile|
        File.exist?(newfile) && File.stat(newfile).mtime > File.stat(oldfile).mtime
      })
    now = Time.now

    create_file(oldfile, now - 60)

    newfiles.each do |newfile|
      create_file(newfile, now)
    end
  end

  def create_dir(dirname)
    FileUtils.mkdir_p(dirname) unless File.exist?(dirname)
    File.stat(dirname).mtime
  end

  def create_file(name, file_time=nil)
    create_dir(File.dirname(name))
    FileUtils.touch(name) unless File.exist?(name)
    File.utime(file_time, file_time, name) unless file_time.nil?
    File.stat(name).mtime
  end

  def delete_file(name)
    File.delete(name) rescue nil
  end
end
