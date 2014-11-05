#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module MyApplication
  module Business
    class Company < ActiveRecord::Base
      attr_protected :rating
    end

    class Firm < Company
      has_many :clients, :order => "id", :dependent => :destroy
      has_many :clients_sorted_desc, :class_name => "Client", :order => "id DESC"
      has_many :clients_of_firm, :foreign_key => "client_of", :class_name => "Client", :order => "id"
      has_many :clients_like_ms, :conditions => "name = 'Microsoft'", :class_name => "Client", :order => "id"
      has_many :clients_using_sql, :class_name => "Client", :finder_sql => 'SELECT * FROM companies WHERE client_of = #{id}'

      has_one :account, :dependent => :destroy
    end

    class Client < Company
      belongs_to :firm, :foreign_key => "client_of"
      belongs_to :firm_with_other_name, :class_name => "Firm", :foreign_key => "client_of"

      class Contact < ActiveRecord::Base; end
    end

    class Developer < ActiveRecord::Base
      has_and_belongs_to_many :projects
      validates_length_of :name, :within => (3..20)
    end

    class Project < ActiveRecord::Base
      has_and_belongs_to_many :developers
    end

  end

  module Billing
    class Firm < ActiveRecord::Base
      self.table_name = 'companies'
    end

    module Nested
      class Firm < ActiveRecord::Base
        self.table_name = 'companies'
      end
    end

    class Account < ActiveRecord::Base
      with_options(:foreign_key => :firm_id) do |i|
        i.belongs_to :firm, :class_name => 'MyApplication::Business::Firm'
        i.belongs_to :qualified_billing_firm, :class_name => 'MyApplication::Billing::Firm'
        i.belongs_to :unqualified_billing_firm, :class_name => 'Firm'
        i.belongs_to :nested_qualified_billing_firm, :class_name => 'MyApplication::Billing::Nested::Firm'
        i.belongs_to :nested_unqualified_billing_firm, :class_name => 'Nested::Firm'
      end

      protected
        def validate
          errors.add_on_empty "credit_limit"
        end
    end
  end
end
