defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """

  use Bitwise

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    secret_handshake = []
    wink = wink?(secret_handshake, code)
    double_blink = double_blink?(wink, code)
    close_your_eyes = close_your_eyes?(double_blink, code)
    jump = jump?(close_your_eyes, code)

    reverse?(jump, code)
  end

  def wink?(handshake, code) do
    wink = 0b1
    if (wink &&& code) == wink do
      [ "wink" | handshake ]
    else
      handshake
    end
  end

  def double_blink?(handshake, code) do
    double_blink = 0b10
    if (double_blink &&& code) == double_blink do
      [ "double blink" | handshake ]
    else
      handshake
    end
  end

  def close_your_eyes?(handshake, code) do
    close_your_eyes = 0b100
    if (close_your_eyes &&& code) == close_your_eyes do
      [ "close your eyes" | handshake ]
    else
      handshake
    end
  end

  def jump?(handshake, code) do
    jump = 0b1000
    if (jump &&& code) == jump do
      [ "jump" | handshake ]
    else
      handshake
    end
  end

  def reverse?(handshake, code) do
    reverse = 0b10000
    if (reverse &&& code) == reverse do
      handshake
    else
      Enum.reverse(handshake)
    end
  end

end