#---
# Excerpted from "Craft GraphQL APIs in Elixir with Absinthe",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/wwgraphql for more book information.
#---
defmodule PlateSlateWeb.Schema.AccountsTypes do
  use Absinthe.Schema.Notation

  object :session do
    field :token, :string
    field :user, :user
  end

  enum :role do
    value :employee
    value :customer
  end

  interface :user do
    field :email, :string
    field :name, :string

    resolve_type fn
      %{role: "employee"}, _ -> :employee
      %{role: "customer"}, _ -> :customer
    end
  end

  object :employee do
    interface :user
    field :email, :string
    field :name, :string
  end

  object :customer do
    interface :user
    field :email, :string
    field :name, :string
    field :orders, list_of(:order)
  end
end
