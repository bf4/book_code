all: beam
	erl -s cgi_web_server start

## the next line starts the server om port 5000

batch_start: beam
	erl -s cgi_web_server start_from_shell 5000

beam: 
	erlc *.erl 

clean:
	rm -rf *~ *.beam *.tmp
