#!/bin/sh
#---
# Excerpted from "HTML5 and CSS3 Second Edition",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/bhh52e for more book information.
#---

# A script to build WebSocketMain.swf and WebSocketMainInsecure.zip.

# You need Flex 4 SDK:
# http://opensource.adobe.com/wiki/display/flexsdk/Download+Flex+4

mxmlc \
  -static-link-runtime-shared-libraries \
  -target-player=10.0.0 \
  -output=../WebSocketMain.swf \
  -source-path=src -source-path=third-party \
  src/net/gimite/websocket/WebSocketMain.as &&

mxmlc \
  -static-link-runtime-shared-libraries \
  -target-player=10.0.0 \
  -output=../WebSocketMainInsecure.swf \
  -source-path=src -source-path=third-party \
  src/net/gimite/websocket/WebSocketMainInsecure.as &&

cd .. &&

zip WebSocketMainInsecure.zip WebSocketMainInsecure.swf &&
rm WebSocketMainInsecure.swf
