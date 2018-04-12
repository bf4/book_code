#---
# Excerpted from "Craft GraphQL APIs in Elixir with Absinthe",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/wwgraphql for more book information.
#---
defmodule PlateSlateWeb.Schema.Mutation.LoginEmployeeTest do
  use PlateSlateWeb.ConnCase, async: true

  @query """
  mutation ($email: String!) {
    login(role: EMPLOYEE, email:$email,password:"super-secret") {
      token
      user { name }
    }
  }
  """
  test "creating an employee session" do
    user = Factory.create_user("employee")
    response = post(build_conn(), "/api", %{
      query: @query,
      variables: %{"email" => user.email}
    })

    assert %{"data" => %{ "login" => %{
      "token" => token,
      "user" => user_data
    }}} = json_response(response, 200)

    assert %{"name" => user.name} == user_data
    assert {:ok, %{role: :employee, id: user.id}} ==
      PlateSlateWeb.Authentication.verify(token)
  end
end
