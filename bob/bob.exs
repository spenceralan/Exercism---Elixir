defmodule Bob do
  def hey(input) do
    cond do
      question?(input) ->
        "Sure."
      silence?(input) ->
        "Fine. Be that way!"
      yelling?(input) ->
        "Whoa, chill out!"
      true ->
        "Whatever."
    end
  end

  def question?(input) do
    String.ends_with?(input, "?")
  end
  
  def yelling?(input) do
    Regex.match?(~r/\p{L}/, input) &&
    String.upcase(input)
    |> String.equivalent?(input)
  end

  def silence?(input) do
    String.trim(input)
    |> String.length() == 0
  end
end
