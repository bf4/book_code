default: thermostat

OBJS := thermostat.o cucumber.o listener.o

thermostat: $(OBJS)
	gcc -o thermostat $(OBJS)

%.o: %.c
	gcc -c $<
