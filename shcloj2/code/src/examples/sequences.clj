;;
;;Excerpted from "Programming Clojure, Second Edition",
;;published by The Pragmatic Bookshelf.
;;Copyrights apply to this code. It may not be used to create training material, 
;;courses, books, articles, and the like. Contact us if you are in doubt.
;;We make no guarantees that this code is fit for any purpose. 
;;Visit http://www.pragmaticprogrammer.com/titles/shcloj2 for more book information.
;;
(ns examples.sequences
    (:use examples.utils clojure.set clojure.xml))

(def song {:name "Agnus Dei"
	   :artist "Krzysztof Penderecki"
	   :album "Polish Requiem"
	   :genre "Classical"})

(def compositions 
  #{{:name "The Art of the Fugue" :composer "J. S. Bach"}
    {:name "Musical Offering" :composer "J. S. Bach"}
    {:name "Requiem" :composer "Giuseppe Verdi"}
    {:name "Requiem" :composer "W. A. Mozart"}})
(def composers
  #{{:composer "J. S. Bach" :country "Germany"}
    {:composer "W. A. Mozart" :country "Austria"}
    {:composer "Giuseppe Verdi" :country "Italy"}})
(def nations
  #{{:nation "Germany" :language "German"}
    {:nation "Austria" :language "German"}
    {:nation "Italy" :language "Italian"}})


; TODO: add pretty-print that works with book margins.
(defdemo demo-map-builders
  (assoc song :kind "MPEG Audio File")
  (dissoc song :genre)
  (select-keys song [:name :artist])
  (merge song {:size 8118166 :time 507245}))

(defdemo demo-merge-with
  (merge-with 
   concat 
   {:flintstone, ["Fred"], :rubble ["Barney"]}
   {:flintstone, ["Wilma"], :rubble ["Betty"]}
   {:flintstone, ["Pebbles"], :rubble ["Bam-Bam"]}))

(def languages #{"java" "c" "d" "clojure"})
(def beverages #{"java" "chai" "pop"})

(defdemo demo-mutable-re
; don't do this!
(let [m (re-matcher #"\w+" "the quick brown fox")]
  (loop [match (re-find m)]
    (when match
      (println match)
      (recur (re-find m)))))
)

(defn minutes-to-millis [mins] (* mins 1000 60))

(defn recently-modified? [file]
  (> (.lastModified file) 
     (- (System/currentTimeMillis) (minutes-to-millis 30))))

(use '[clojure.java.io :only (reader)])
(defn non-blank? [line] (if (re-find #"\S" line) true false))

(defn non-svn? [file] (not (.contains (.toString file) ".svn")))

(defn clojure-source? [file] (.endsWith (.toString file) ".clj"))

(defn clojure-loc [base-file]
  (reduce 
   +
   (for [file (file-seq base-file) 
	 :when (and (clojure-source? file) (non-svn? file))]
     (with-open [rdr (reader file)]
       (count (filter non-blank? (line-seq rdr)))))))

(defn demo-xml-seq []
(for [x (xml-seq 
	 (parse (java.io.File. "data/sequences/compositions.xml")))
      :when (= :composition (:tag x))]
  (:composer (:attrs x)))
)



