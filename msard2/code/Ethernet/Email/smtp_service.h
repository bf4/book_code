/***
 * Excerpted from "Arduino: A Quick-Start Guide, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/msard2 for more book information.
***/
#ifndef __SMTP_SERVICE__H_
#define __SMTP_SERVICE__H_

#include "email.h"

class SmtpService {
  boolean      _use_auth;
  IPAddress    _smtp_server;
  unsigned int _port;
  String       _username;
  String       _password;
 
  void read_response(EthernetClient& client) { 
    delay(4000);
    while (client.available()) {
      const char c = client.read();
      Serial.print(c);
    }
  }

  void send_line(EthernetClient& client, String line) { 
    const unsigned int MAX_LINE = 256;
    char buffer[MAX_LINE];
    line.toCharArray(buffer, MAX_LINE);
    Serial.println(buffer);
    client.println(buffer);
    read_response(client);
  }

  public:
  
  SmtpService( 
    const IPAddress&   smtp_server,
    const unsigned int port) : _use_auth(false),
                               _smtp_server(smtp_server), 
                               _port(port) { }
                               
  SmtpService( 
    const IPAddress&   smtp_server,
    const unsigned int port,
    const String&      username,
    const String&      password) : _use_auth(true),
                                   _smtp_server(smtp_server), 
                                   _port(port),
                                   _username(username),
                                   _password(password) { }
                               
  void send_email(const Email& email) { 
    EthernetClient client;
    Serial.print("Connecting...");
  
    if (client.connect(_smtp_server, _port) <= 0) {
      Serial.println("connection failed.");
    } else {
      Serial.println("connected.");
      read_response(client);
      if (!_use_auth) { 
        Serial.println("Using no authentication.");
        send_line(client, "helo");
      }
      else {
        Serial.println("Using authentication.");
        send_line(client, "ehlo");
        send_line(client, "auth login");
        send_line(client, _username);
        send_line(client, _password);
      }
      send_line(
        client,
        "mail from: <" + email.getFrom() + ">"
      );
      send_line(
        client,
        "rcpt to: <" + email.getTo() + ">"
      );
      send_line(client, "data");
      send_line(client, "from: " + email.getFrom());
      send_line(client, "to: " + email.getTo());
      send_line(client, "subject: " + email.getSubject());
      send_line(client, "");
      send_line(client, email.getBody());
      send_line(client, ".");
      send_line(client, "quit");    
      client.println("Disconnecting.");
      client.stop();
    }
  }
};

#endif
