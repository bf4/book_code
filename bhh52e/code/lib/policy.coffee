# Flash policy file support for flash fallback
pf = require('policyfile').createServer()

pf.listen 843, ->
  console.log "Flash Policy server listening on port 843"

pf.on "error", (message) -> 
  console.log """
    *******************************************************************
    * CAN'T START POLICY SERVER. Port 843 requires you to run as root *
    * Try running this with sudo node server instead.                 *
    *******************************************************************
  """

