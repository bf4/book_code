require 'fileutils'

include FileUtils

task :clean_named_screenshots do
  rm_rf 'spec/screenshots/named'
  mkdir_p 'spec/screenshots/named'
end

desc "Sync code in this repo with the book's code/ directory"
task :sync_code => [:clean_named_screenshots,:spec] do
  current_branch = `git rev-parse --abbrev-ref HEAD`.chomp
  fail "You should run this from the branch in question" if current_branch == "master"
  fail "Your branch should have a slash in it for the chapter name" unless current_branch =~ /\//
  changed_files = `git status --porcelain`.split("\n")
  fail "ERROR: You have local changes" unless changed_files.empty?

  code_dir = File.expand_path("../dcbang/Book/code")
  images_dir = File.expand_path("../dcbang/Book/images")

  fail "Can't find the code directory.  Expected it to be in #{code_dir}" unless File.exists?(code_dir)
  fail "Can't find the images directory.  Expected it to be in #{images_dir}" unless File.exists?(images_dir)

  code_branch_dir = File.join(code_dir,current_branch,"shine")
  puts "Syncing code to #{code_branch_dir}"
  mkdir_p code_branch_dir
  puts `rsync --exclude .git --exclude tmp --exclude log --exclude spec/screenshots -av . #{code_branch_dir}`

  images_branch_dir = File.join(images_dir,current_branch)
  puts "Syncing screenshots to #{images_branch_dir}..."
  mkdir_p images_branch_dir
  puts `rsync -av spec/screenshots/named/ #{images_branch_dir}`
end
