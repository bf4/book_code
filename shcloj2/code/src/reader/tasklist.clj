;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns reader.tasklist
  (:gen-class ; <label id="code.tasklist.genclass"/>
   :extends org.xml.sax.helpers.DefaultHandler ; <label id="code.tasklist.extends"/>
   :state state ; <label id="code.tasklist.state"/>
   :init init) ; <label id="code.tasklist.init"/>
  (:use [clojure.java.io :only (reader)])
  (:import [java.io File]
           [org.xml.sax InputSource]
	   [org.xml.sax.helpers DefaultHandler]
	   [javax.xml.parsers SAXParserFactory]))
