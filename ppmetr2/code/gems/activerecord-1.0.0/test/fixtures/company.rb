#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Company < ActiveRecord::Base
  attr_protected :rating
end


class Firm < Company
  has_many :clients, :order => "id", :dependent => true
  has_many :clients_sorted_desc, :class_name => "Client", :order => "id DESC"
  has_many :clients_of_firm, :foreign_key => "client_of", :class_name => "Client", :order => "id"
  has_many :clients_like_ms, :conditions => "name = 'Microsoft'", :class_name => "Client", :order => "id"
  has_many :clients_using_sql, :class_name => "Client", :finder_sql => 'SELECT * FROM companies WHERE client_of = #{id}'

  has_one :account, :dependent => true
end

class Client < Company
  belongs_to :firm, :foreign_key => "client_of"
  belongs_to :firm_with_basic_id, :class_name => "Firm", :foreign_key => "firm_id"
  belongs_to :firm_with_other_name, :class_name => "Firm", :foreign_key => "client_of"
  belongs_to :firm_with_condition, :class_name => "Firm", :foreign_key => "client_of", :conditions => "1 = 1"
end


class SpecialClient < Client
end

class VerySpecialClient < SpecialClient
end

class Account < ActiveRecord::Base
  belongs_to :firm
  
  protected
    def validate
      errors.add_on_empty "credit_limit"
    end
end
