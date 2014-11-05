#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
configuration do |c|
	# Undocumented option 'project_name'
	# default value: "work"
	#
	#c.project_name = "work"

	# Undocumented option 'output_dir'
	# default value: "package"
	#
	#c.output_dir = "package"

	# Undocumented option 'main_ruby_file'
	# default value: "main"
	#
	#c.main_ruby_file = "main"

	# Undocumented option 'main_java_file'
	# default value: "org.rubyforge.rawr.Main"
	#
	#c.main_java_file = "org.rubyforge.rawr.Main"

	# Undocumented option 'source_dirs'
	# default value: ["src", "lib/ruby"]
	#
	#c.source_dirs = ["src", "lib/ruby"]

	# Undocumented option 'source_exclude_filter'
	# default value: []
	#
	#c.source_exclude_filter = []

	# Undocumented option 'jruby_jar'
	# default value: "lib/java/jruby-complete.jar"
	#
	#c.jruby_jar = "lib/java/jruby-complete.jar"

	# Undocumented option 'compile_ruby_files'
	# default value: true
	#
	#c.compile_ruby_files = true

	# Undocumented option 'java_lib_files'
	# default value: []
	#
	#c.java_lib_files = []

	# Undocumented option 'java_lib_dirs'
	# default value: ["lib/java"]
	#
	#c.java_lib_dirs = ["lib/java"]

	# Undocumented option 'files_to_copy'
	# default value: []
	#
	#c.files_to_copy = []

	# Undocumented option 'target_jvm_version'
	# default value: 1.6
	#
	#c.target_jvm_version = 1.6

	# Undocumented option 'jvm_arguments'
	# default value: ""
	#
	#c.jvm_arguments = ""

	# Undocumented option 'java_library_path'
	# default value: ""
	#
	#c.java_library_path = ""

	# Undocumented option 'extra_user_jars'
	# default value: {}
	#
	#c.extra_user_jars[:data] = { :directory => 'data/images/png',
	#                             :location_in_jar => 'images',
	#                             :exclude => /*.bak$/ }

	# Undocumented option 'mac_do_not_generate_plist'
	# default value: nil
	#
	#c.mac_do_not_generate_plist = nil

	# Undocumented option 'mac_icon_path'
	# default value: "GenericJavaApp.icns"
	#
	#c.mac_icon_path = "GenericJavaApp.icns"

	# Undocumented option 'windows_icon_path'
	# default value: "GenericJavaApp.ico"
	#
	#c.windows_icon_path = "GenericJavaApp.ico"

  c.mac_icon_path = File.expand_path('icons/monkeybars.icns')
  c.windows_icon_path = File.expand_path('icons/monkeybars.ico')
end

