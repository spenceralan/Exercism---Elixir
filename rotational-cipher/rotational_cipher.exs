defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()

  @letters "abcdefghijklmnopqrstuvwxyz"
  @lower String.codepoints(@letters)
  @upper Enum.map(@lower, fn(char) -> String.upcase(char) end)
  @number_of_positions String.length(@letters)

  def rotate(text, shift) do
    String.codepoints(text)
    |> Enum.map(fn(char) ->
      lower_char = String.downcase(char)
      if Enum.member?(@lower, lower_char) do
        encoded_char(char, shift)
      else
        char
      end
    end)
    |> Enum.join()
  end

  def encoded_char(char, shift) do
    lower_index = Enum.find_index(@lower, fn(letter) -> char == letter end)
    upper_index = Enum.find_index(@upper, fn(letter) -> char == letter end)

    cond do
      lower_index ->
        position = lower_index
        new_position = new_position(position, shift)
        {:ok, encoded_char} = Enum.fetch(@lower, new_position)
        encoded_char
      upper_index ->
        position = upper_index
        new_position = new_position(position, shift)
        {:ok, encoded_char} = Enum.fetch(@upper, new_position)
        encoded_char
    end

  end

  def new_position(position, shift) do
    new_position = position + shift
    cond do
      new_position < @number_of_positions ->
        new_position
      new_position > @number_of_positions ->
        new_position - @number_of_positions
      rem(position, shift) == 0 ->
        0
    end
  end
end

