EXAMPLE_SOURCES := $(wildcard *.rb)
EXAMPLE_OUTPUTS := $(notdir $(EXAMPLE_SOURCES:.rb=.out))

ruby_version = rbenv versions | sed 's/^\*//g' | sed 's/(set by.*//g' | grep $(1) | grep -v railsexpress | tr -d ' '

RUBY19 := $(shell $(call ruby_version,1.9.3))
RUBY20 := $(shell $(call ruby_version,2.0.0))
RUBY21 := $(shell $(call ruby_version,2.1))
RUBY22 := $(shell $(call ruby_version,2.2))

examples: $(EXAMPLE_OUTPUTS)

%.out: %.rb
	rbenv local $(RUBY19)
	rbenv exec ruby $<
	rbenv exec ruby $<
	rbenv exec ruby $<
	sleep 1
	rbenv local $(RUBY20)
	rbenv exec ruby $<
	rbenv exec ruby $<
	rbenv exec ruby $<
	sleep 1
	rbenv local $(RUBY21)
	rbenv exec ruby $<
	rbenv exec ruby $<
	rbenv exec ruby $<
	sleep 1
	rbenv local $(RUBY22)
	rbenv exec ruby $<
	rbenv exec ruby $<
	rbenv exec ruby $<
