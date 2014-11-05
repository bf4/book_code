;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.cryptovault
  (:use [examples.io :only [IOFactory make-reader make-writer]])
  (:require [clojure.java.io :as io])
  (:import (java.security KeyStore KeyStore$SecretKeyEntry
                          KeyStore$PasswordProtection)
           (javax.crypto KeyGenerator Cipher CipherOutputStream
                         CipherInputStream)
           (java.io FileOutputStream)))
(deftype CryptoVault [filename keystore password]
  Vault
  (init-vault [vault]
    ... define method body here ...)

  (vault-output-stream [vault]
    ... define method body here ...)

  (vault-input-stream [vault]
    ... define method body here ...)

  IOFactory
  (make-reader [vault]
    (make-reader (vault-input-stream vault)))
  (make-writer [vault]
    (make-writer (vault-output-stream vault))))

(init-vault [vault]
  (let [password (.toCharArray (.password vault))
        key (.generateKey (KeyGenerator/getInstance "AES"))
        keystore (doto (KeyStore/getInstance "JCEKS")
                   (.load nil password)
                   (.setEntry "vault-key"
                              (KeyStore$SecretKeyEntry. key)
                              (KeyStore$PasswordProtection. password)))]
    (with-open [fos (FileOutputStream. (.keystore vault))]
      (.store keystore fos password))))

(defn vault-key [vault]
  (let [password (.toCharArray (.password vault))]
    (with-open [fis (FileInputStream. (.keystore vault))]
      (-> (doto (KeyStore/getInstance "JCEKS")
            (.load fis password))
          (.getKey "vault-key" password)))))

(vault-output-stream [vault]
  (let [cipher (doto (Cipher/getInstance "AES")
                 (.init Cipher/ENCRYPT_MODE (vault-key vault)))]
    (CipherOutputStream. (io/output-stream (.filename vault)) cipher)))

(vault-input-stream [vault]
  (let [cipher (doto (Cipher/getInstance "AES")
                 (.init Cipher/DECRYPT_MODE (vault-key vault)))]
    (CipherInputStream. (io/input-stream (.filename vault)) cipher)))

(extend CryptoVault
  clojure.java.io/IOFactory
  (assoc clojure.java.io/default-streams-impl
    :make-input-stream (fn [x opts] (vault-input-stream x))
    :make-output-stream (fn [x opts] (vault-output-stream x))))
                                        