#include "infrared_proxy.h"

void InfraredProxy::read_line(
  EthernetClient& client, char* buffer, const int buffer_length)
{
  int buffer_pos = 0;
  while (client.available() && (buffer_pos < buffer_length - 1)) {
    const char c = client.read();
    if (c == '\n')
      break;
    if (c != '\r')
      buffer[buffer_pos++] = c;
  }
  buffer[buffer_pos] = '\0';
}

bool InfraredProxy::send_ir_data(
  const char* protocol, const int bits, const long value)
 {
  bool result = true;
  if (!strcasecmp(protocol, "NEC"))
    _infrared_sender.sendNEC(value, bits);
  else if (!strcasecmp(protocol, "SONY"))
    _infrared_sender.sendSony(value, bits);
  else if (!strcasecmp(protocol, "RC5"))
    _infrared_sender.sendRC5(value, bits);
  else if (!strcasecmp(protocol, "RC6"))
    _infrared_sender.sendRC6(value, bits);
  else if (!strcasecmp(protocol, "DISH"))
    _infrared_sender.sendDISH(value, bits);
  else if (!strcasecmp(protocol, "SHARP"))
    _infrared_sender.sendSharp(value, bits);
  else if (!strcasecmp(protocol, "JVC"))
    _infrared_sender.sendJVC(value, bits, 0);
  else if (!strcasecmp(protocol, "SAMSUNG"))
    _infrared_sender.sendSAMSUNG(value, bits);
  else
    result = false;
  return result;
}

bool InfraredProxy::handle_command(char* line) {
  strsep(&line, " "); 
  char* path = strsep(&line, " "); 

  char* args[3];
  for (char** ap = args; (*ap = strsep(&path, "/")) != NULL;) 
    if (**ap != '\0')
      if (++ap >= &args[3])
        break; 
  const int  bits = atoi(args[1]);
  const long value = strtoul(args[2], NULL, 16);
  return send_ir_data(args[0], bits, value);
}
  
void InfraredProxy::receive_from_server(EthernetServer server) {
  const int MAX_LINE = 256;
  char line[MAX_LINE];
  EthernetClient client = server.available(); 
  if (client) {
    while (client.connected()) {
      if (client.available()) { 
        read_line(client, line, MAX_LINE);
        Serial.println(line);
        if (line[0] == 'G' && line[1] == 'E' && line[2] == 'T')
          handle_command(line);
        if (!strcmp(line, "")) {
          client.println("HTTP/1.1 200 OK\n");
          break;
        }
      }
    }
    delay(1);
    client.stop();
  }
}  

