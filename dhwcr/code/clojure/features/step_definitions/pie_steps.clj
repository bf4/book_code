(use 'pie.core)
(Given #"^the oven is preheated to (\d+)$" [degrees]
       (preheat-oven degrees))
(When #"^I bake the pie for (\d+) minutes$" [minutes]
      (bake-for minutes))
(Then #"^it should taste delicious$" []
      (assert (= (pie-taste) 'delicious)))
