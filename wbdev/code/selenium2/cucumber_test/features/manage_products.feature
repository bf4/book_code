# START:whole_file
Feature: Manage products with the QED Server
  Scenario: When I view the product details of a new product it should take me 
            to the page where the product information is displayed
      Given I am on the Products management page
      And I created a product called "iPad 3" with a price of "500" #<label id="code.manage.and"/>
        dollars and a description of "My iPad 3 test product"
      When I view the details of "iPad 3" #<label id="code.manage.when" />
      Then I should see "iPad 3"
      And I should see a price of "500"  #<label id="code.manage.2" />
      And I should see a description of "My iPad 3 test product" #<label id="code.manage.3"/>
# END:whole_file
