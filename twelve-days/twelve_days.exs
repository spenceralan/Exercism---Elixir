defmodule TwelveDays do

  @gifts [
    "a Partridge in a Pear Tree.",
    "two Turtle Doves",
    "three French Hens",
    "four Calling Birds",
    "five Gold Rings",
    "six Geese-a-Laying",
    "seven Swans-a-Swimming",
    "eight Maids-a-Milking",
    "nine Ladies Dancing",
    "ten Lords-a-Leaping",
    "eleven Pipers Piping",
    "twelve Drummers Drumming",
  ]

  @nth %{
    "1" => "first",
    "2" => "second",
    "3" => "third",
    "4" => "fourth",
    "5" => "fifth",
    "6" => "sixth",
    "7" => "seventh",
    "8" => "eighth",
    "9" => "ninth",
    "10" => "tenth",
    "11" => "eleventh",
    "12" => "twelfth",
  }

  def opening(nth) do
    numbered = Map.get(@nth, Integer.to_string(nth))
    "On the #{numbered} day of Christmas my true love gave to me"
  end

  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    gifts = Enum.take(@gifts, number)
    |> List.delete_at(0)
    |> Enum.reverse
    opening = [ opening(number) | gifts ]
    verse = [ Enum.join(opening, ", ") | [Enum.at(@gifts, 0)] ]
    if number > 1 do
      Enum.join(verse, ", and ")
    else
      Enum.join(verse, ", ")
    end
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    Enum.to_list(starting_verse..ending_verse)
    |> Enum.reduce("", fn(x, acc) ->
      Enum.join([acc, verse(x)], "\n")
    end)
    |> String.trim
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing():: String.t()
  def sing do
    verses(1, 12)
  end
end

