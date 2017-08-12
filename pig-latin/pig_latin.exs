defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """

  @vowel_phonemes [
    "yt",
    "xr",
    "a",
    "e",
    "i",
    "o",
    "u",
  ]
  @consonant_phonemes [
    "ch",
    "qu",
    "sch",
    "squ",
    "thr",
    "th",
    "b",
    "c",
    "d",
    "f",
    "g",
    "h",
    "j",
    "k",
    "l",
    "m",
    "n",
    "p",
    "q",
    "r",
    "s",
    "t",
    "v",
    "w",
    "x",
    "y",
    "z",
  ]

  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(" ")
    |> Enum.map(fn(word) ->
      cond do
        String.starts_with?(word, @vowel_phonemes) ->
          add_ay(word)
        String.starts_with?(word, @consonant_phonemes) ->
          move_consonant_phoneme(word)
          |> add_ay()
        true ->
          word
      end
    end)
    |> Enum.join(" ")
  end

  def add_ay(word) do
    word <> "ay"
  end

  def move_consonant_phoneme(word) do 
    phoneme = @consonant_phonemes
    |> Enum.find(fn(phoneme) ->
      String.starts_with?(word, phoneme)
    end)
    phoneme_length = String.length(phoneme)
    word_less_phoneme = String.slice(word, phoneme_length..-1)
    word_less_phoneme <> phoneme
  end
end

