/***
 * Excerpted from "Arduino: A Quick-Start Guide, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/msard2 for more book information.
***/
#ifndef __EMAIL__H_
#define __EMAIL__H_

class Email {
  String _from, _to, _subject, _body;
  
  public:
  
  Email(
    const String& from,
    const String& to,
    const String& subject,
    const String& body
  ) : _from(from), _to(to), _subject(subject), _body(body) {}

  const String& getFrom()    const { return _from; }
  const String& getTo()      const { return _to; }
  const String& getSubject() const { return _subject; }
  const String& getBody()    const { return _body; }
};

#endif
