defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    parse(sentence)
    |> Enum.reduce(%{}, fn(x, acc) ->
      if Map.has_key?(acc, x) do
        Map.replace(acc, x, acc[x] + 1)
      else
        Map.merge(acc, %{x => 1})
      end
    end)
  end

  def parse(sentence) do
    downcased_string = String.downcase(sentence)
    Regex.scan(~r/
      [[:alnum:]]+
      -*
      [[:alpha:]]*
      /ux, downcased_string)
    |> List.flatten
  end
end
