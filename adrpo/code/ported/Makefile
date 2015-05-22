EXAMPLE_SOURCES := $(wildcard *.rb)
EXAMPLE_OUTPUTS := $(addprefix output/,$(notdir $(EXAMPLE_SOURCES:.rb=.out)))

examples: $(EXAMPLE_OUTPUTS)

output/%.out: %.rb
	rbenv local 1.9.3-p484
	rbenv exec ruby wrapper.rb ./$< > $@
	sleep 10
	rbenv exec ruby wrapper.rb ./$< --no-gc >> $@
	sleep 10
	rbenv local 2.0.0-p353
	rbenv exec ruby wrapper.rb ./$< >> $@
	sleep 10
	rbenv exec ruby wrapper.rb ./$< --no-gc >> $@
	sleep 10
	rbenv local 2.1.0
	rbenv exec ruby wrapper.rb ./$< >> $@
	sleep 10
	rbenv exec ruby wrapper.rb ./$< --no-gc >> $@
	rbenv exec ruby format_output.rb $@
