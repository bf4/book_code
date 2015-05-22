#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
defmodule Validator do

  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__)
      Module.register_attribute(__MODULE__, :validations, accumulate: true)
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def validate(attrs) do
        @validations
        |> Enum.map(fn {key, rules} -> apply_rules(key, attrs[key], rules) end)
        |> Enum.group_by(fn {key, errors} -> key end)
        |> Enum.map(fn {key, nested_errors} ->
          {key, nested_errors |> Dict.values |> List.flatten}
        end)
        |> Enum.filter(fn {_key, errors} -> errors != [] end)
        |> case do
          []     -> :ok
          errors -> {:error, errors}
        end
      end
    end
  end

  defmacro validate(attribute, rules) do
    quote do
      @validations {unquote(attribute), unquote(rules)}
    end
  end

  def apply_rules(attr, value, rules) do
    {attr, rules
           |> Enum.map(&apply_rule(attr, value, &1))
           |> Enum.filter(&(&1 != :ok))}
  end

  defp apply_rule(attr, val, {:format, :string}) do
    :ok
  end

  defp apply_rule(attr, val, {:format, :integer}) when is_integer(val) do
    :ok
  end
  defp apply_rule(attr, val, {:format, :integer}) do
    case Integer.parse(to_string(val)) do
      {_int, _} -> :ok
      :error    -> "#{attr} must be an integer"
    end
  end
  defp apply_rule(attr, val, {:format, regex}) do
    if Regex.match?(regex, to_string(val)) do
      :ok
    else
      "#{attr} is improperly formatted"
    end
  end

  defp apply_rule(attr, val, {:format, :float}) when is_float(val) do
    :ok
  end
  defp apply_rule(attr, val, {:format, :float}) do
    case Float.parse(to_string(val)) do
      {_float, _} -> :ok
      :error      -> "#{attr} is must be a float"
    end
  end

  defp apply_rule(attr, val, {:length, min..max}) do
    val = to_string(val)
    len = String.length(val)
    if len >= min and len <= max do
      :ok
    else
      "#{attr} must be between #{min} and #{max} characters long"
    end
  end
  defp apply_rule(attr, val, {:presence, true}) when val in [nil, ""] do
    "#{attr} cannot be blank"
  end
  defp apply_rule(attr, val, {:presence, true}) do
    :ok
  end

  defp apply_rule(attr, val, {:within, min..:"+infinity"}) when val >= min do
    :ok
  end
  defp apply_rule(attr, _val, {:within, min..:"+infinity"}) do
    "#{attr} must be greater than or equal to #{min}"
  end
  defp apply_rule(attr, val, {:within, :"-infinity"..max}) when val <= max do
    :ok
  end
  defp apply_rule(attr, _val, {:within, :"-infinity"..max}) do
    "#{attr} must be less than or equal to #{max}"
  end
  defp apply_rule(attr, val, {:within, min..max}) when val <= min and val >= max do
    :ok
  end
  defp apply_rule(attr, _val, {:within, min..max}) do
    "#{attr} must be between #{min} and #{max}"
  end

  defp apply_rule(attr, val, {:not_in, collection}) do
    if Enum.member?(collection, val) do
      "#{attr} must be one of #{Enum.join(collection, ", ")}"
    else
      :ok
    end
  end
end

defmodule UserValidator do
  use Validator

  validate :username, length: 1..15,
                      not_in: ["admin", "root"]

  validate :name,     length: 1..10

  validate :bio,      presence: true

  validate :bio,      format: ~r/.+/

  validate :age,      format: :integer,
                      within: 0..:"+infinity"

  validate :password, length: 1..255

  validate :email,    format: ~r/^\S+@\S+\.\S+$/

end

