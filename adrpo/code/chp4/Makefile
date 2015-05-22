all: example_api example_command example_app optimization_session

example_api:
	bundle exec ruby ruby_prof_example_api1.rb

example_command:
	ruby-prof -p flat -m 1 -f ruby_prof_example_command_profile.txt ruby_prof_example_command.rb
	sed -i 's/^\(.\{84\}\).*$$/\1/' ruby_prof_example_command_profile.txt

example_app:
	bundle exec ruby app.rb
	sed -i '/^\* indicates recursively/d' app_graph_profile.txt
	html2text -width 84 app_call_stack_profile.html > app_call_stack_profile.txt
	sed -i 's/minus.png/-/' app_call_stack_profile.txt
	sed -i 's/plus.png/+/' app_call_stack_profile.txt
	sed -i '/empty\.png] Use/d' app_call_stack_profile.txt
	sed -i '/empty\.png] Click/d' app_call_stack_profile.txt
	sed -i '/empty\.png] Enter/d' app_call_stack_profile.txt
	sed -i 's/empty.png/ /' app_call_stack_profile.txt
	sed -i '/to hide/d' app_call_stack_profile.txt
	sed -i '/hide all nodes/d' app_call_stack_profile.txt
	sed -i '/^[ ]\{46\}/d' app_call_stack_profile.txt
