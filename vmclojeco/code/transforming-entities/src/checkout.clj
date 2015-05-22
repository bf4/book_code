;---
; Excerpted from "Clojure Applied",
; published by The Pragmatic Bookshelf.
; Copyrights apply to this code. It may not be used to create training material, 
; courses, books, articles, and the like. Contact us if you are in doubt.
; We make no guarantees that this code is fit for any purpose. 
; Visit http://www.pragmaticprogrammer.com/titles/vmclojeco for more book information.
;---
(require '[money :refer [make-money +$ *$])

;; catalog items
(defrecord Item          [item-number category
                          desc price])
;; checkout concerns
(defrecord Cart          [number customer line-items])
(defrecord LineItem      [quantity item-number price])
(defrecord Customer      [name email membership-number])
(defrecord BillingRecord [customer transaction-number
                          payment-type amount tax total])

(defn- acc-subtotal
  "accumulate line item total into an existing subtotal."
  [subt li]
  (+$ subt (*$ (:quantity li) (:price li))))

(defn- tax-rate
  "find a customer's local tax rate"
  [cust]
  ,,, )

(defn cart->billing-record [c]
  (let [subtotal (reduce acc-subtotal
                    (make-money) ;
                    (:line-items cart))
        rate     (tax-rate (:customer c))
        tax      (*$ subtotal rate)
        total    (+$ subtotal tax)]
    (map->BillingRecord {
      :customer (:customer c)
      :amount   subtotal
      :tax      tax
      :total    total
      })))

(defn checkout
  "checkout a cart: bill the customer and persist the
   billing record."
  [cart]
  (let [billing-record (cart->billing-record cart)]
    ,,, ))
