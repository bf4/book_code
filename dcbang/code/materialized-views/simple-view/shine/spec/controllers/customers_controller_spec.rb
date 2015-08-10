#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dcbang for more book information.
#---
require 'rails_helper'

describe CustomersController do
  describe "#index" do
    before do
      sign_in create(:user)
      @first_name_match  = create(:customer, first_name: "JJones")
      @last_name_match   = create(:customer, last_name: "JJones")
      @email_match       = create(:customer, email: "jjones1234@whatever.com")
      5.times { create(:customer) }
    end
    context "html" do
      before do
        get :index, keywords: keywords
      end
      context "no search criteria" do
        let(:keywords) { nil }
        specify { expect(response.code).to eq("200") }
        specify { expect(assigns(:customers)).to eq([]) }
      end
      context "search criteria" do
        context "search by email" do
          let(:keywords) { "jjones1234@whatever.com" }
          specify { expect(response.code).to eq("200") }
          it "returns the matching results by first name, last name, or email" do
            expect(assigns(:customers)).to include(@first_name_match)
            expect(assigns(:customers)).to include(@last_name_match)
            expect(assigns(:customers)).to include(@email_match)
            expect(assigns(:customers).first).to eq(@email_match)
            expect(assigns(:customers).size).to eq(3)
          end
        end
        context "search by name" do
          let(:keywords) { "jjones" }
          specify { expect(response.code).to eq("200") }
          it "returns the matching results by first name, last name, or email" do
            expect(assigns(:customers)).to include(@first_name_match)
            expect(assigns(:customers)).to include(@last_name_match)
            expect(assigns(:customers).size).to eq(2)
          end
        end
      end
    end

    context "json" do
      before do
        get :index, keywords: keywords, format: :json
        @parsed_customers = JSON.parse(response.body)
      end
      context "no search criteria" do
        let(:keywords) { nil }
        specify { expect(response.code).to eq("200") }
        specify { expect(@parsed_customers).to eq([]) }
      end
      context "search criteria" do
        context "search by email" do
          let(:keywords) { "jjones1234@whatever.com" }
          specify { expect(response.code).to eq("200") }
          it "returns the matching results by first name, last name, or email" do
            expect(@parsed_customers.map { |_| _["id"] }).to include(@first_name_match.id)
            expect(@parsed_customers.map { |_| _["id"] }).to include(@last_name_match.id)
            expect(@parsed_customers.map { |_| _["id"] }).to include(@email_match.id)

            expect(@parsed_customers.first["id"]).to eq(@email_match.id)
            expect(@parsed_customers.size).to eq(3)
          end
        end
        context "search by name" do
          let(:keywords) { "jjones" }
          specify { expect(response.code).to eq("200") }
          it "returns the matching results by first name, last name, or email" do
            expect(@parsed_customers.map { |_| _["id"] }).to include(@first_name_match.id)
            expect(@parsed_customers.map { |_| _["id"] }).to include(@last_name_match.id)

            expect(@parsed_customers.size).to eq(2)
          end
        end
      end
    end
  end

  describe "show" do
    let(:customer) { 
      create(:customer).tap { |customer|
        state = State.find_or_create_by!(code: "XX", name: "XX")
        CustomersBillingAddress.create!(
          customer: customer,
          address: Address.create!(street: Faker::Address.street_address,
                                   city: Faker::Address.city,
                                   state: state,
                                   zipcode: Faker::Address.zip))
        3.times do |i|
          CustomersShippingAddress.create!(
            primary: i == 0,
            customer: customer,
            address: Address.create!(street: Faker::Address.street_address,
                                     city: Faker::Address.city,
                                     state: state,
                                     zipcode: Faker::Address.zip)
          )
        end
      }
    }
    before do
      sign_in create(:user)
      get :show, id: customer.id, format: :json
    end
    specify { expect(response.code).to eq("200") }
    it "returns details in JSON" do
      parsed_response = JSON.parse(@response.body)
      expect(parsed_response["first_name"]).to eq(customer.first_name)
      expect(parsed_response["last_name"]).to eq(customer.last_name)
      expect(parsed_response["username"]).to eq(customer.username)
      expect(parsed_response["email"]).to eq(customer.email)

      details = CustomerDetail.find_by(customer_id: customer.id)
      expect(parsed_response["billing_street"]).to eq(details.billing_street)
      expect(parsed_response["billing_city"]).to eq(details.billing_city)
      expect(parsed_response["billing_state"]).to eq(details.billing_state)
      expect(parsed_response["billing_zipcode"]).to eq(details.billing_zipcode)

      expect(parsed_response["shipping_street"]).to eq(details.shipping_street)
      expect(parsed_response["shipping_city"]).to eq(details.shipping_city)
      expect(parsed_response["shipping_state"]).to eq(details.shipping_state)
      expect(parsed_response["shipping_zipcode"]).to eq(details.shipping_zipcode)
    end
  end
end
