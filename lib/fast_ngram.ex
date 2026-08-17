defmodule FastNgram do
  @moduledoc """
  A fast and unicode aware letter & word N-gram library written in Elixir.
  """

  @doc """
  Returns a list of letter N-grams from the given `string`.

  ## Example
      iex> FastNgram.letter_ngrams("¥ · € · $", 3)
      ["¥ ·", " · ", "· €", " € ", "€ ·", " · ", "· $"]
      iex> FastNgram.letter_ngrams("", 2)
      []
      iex> FastNgram.letter_ngrams("abcd", 1)
      ["a", "b", "c", "d"]
      iex> FastNgram.letter_ngrams("abcde", 2)
      ["ab", "bc", "cd", "de"]
  """
  @spec letter_ngrams(String.t(), non_neg_integer) :: list
  def letter_ngrams(string, 1) do
    String.graphemes(string)
  end

  def letter_ngrams(string, n) when is_integer(n) and n > 1 do
    if ascii_only?(string) do
      len = byte_size(string)

      if len < n do
        []
      else
        do_ascii(string, 0, len - n, n)
      end
    else
      case grapheme_sizes(string, n, []) do
        :error ->
          []

        sizes_rev ->
          sizes = :lists.reverse(sizes_rev)
          {:ok, len, rest_sizes} = initial_window(sizes, n, 0)
          do_sliding_ngrams(string, 0, len, rest_sizes, sizes)
      end
    end
  end

  defp grapheme_sizes(binary, 0, acc), do: grapheme_sizes(binary, acc)

  defp grapheme_sizes(binary, n, acc) do
    case :string.next_grapheme(binary) do
      [_ | rest] ->
        size = byte_size(binary) - byte_size(rest)
        grapheme_sizes(rest, n - 1, [size | acc])

      [] ->
        :error
    end
  end

  defp grapheme_sizes(binary, acc) do
    case :string.next_grapheme(binary) do
      [_ | rest] ->
        size = byte_size(binary) - byte_size(rest)
        grapheme_sizes(rest, [size | acc])

      [] ->
        acc
    end
  end

  defp initial_window([s | rest], n, acc) when n > 0 do
    initial_window(rest, n - 1, acc + s)
  end

  defp initial_window(rest, 0, acc), do: {:ok, acc, rest}
  defp initial_window([], _, _), do: :error

  defp ascii_only?(<<
         b1,
         b2,
         b3,
         b4,
         b5,
         b6,
         b7,
         b8,
         rest::binary
       >>)
       when b1 < 128 and b2 < 128 and b3 < 128 and b4 < 128 and b5 < 128 and b6 < 128 and b7 < 128 and
              b8 < 128 do
    ascii_only?(rest)
  end

  defp ascii_only?(<<b, rest::binary>>) when b < 128, do: ascii_only?(rest)
  defp ascii_only?(<<>>), do: true
  defp ascii_only?(_), do: false

  defp do_ascii(string, offset, max_offset, n) when offset < max_offset do
    [binary_part(string, offset, n) | do_ascii(string, offset + 1, max_offset, n)]
  end

  defp do_ascii(string, offset, _, n) do
    [binary_part(string, offset, n)]
  end

  defp do_sliding_ngrams(string, offset, len, [next_s | rest_sizes], [this_s | sizes]) do
    [
      binary_part(string, offset, len)
      | do_sliding_ngrams(string, offset + this_s, len - this_s + next_s, rest_sizes, sizes)
    ]
  end

  defp do_sliding_ngrams(string, offset, len, [], _) do
    [binary_part(string, offset, len)]
  end

  @doc """
  Returns a list of word N-grams from the given `string`.

  ## Example
      iex> FastNgram.word_ngrams("the bus came to a halt", 2)
      ["the bus", "bus came", "came to", "to a", "a halt"]
      iex> FastNgram.word_ngrams("the bus came to a halt", 3)
      ["the bus came", "bus came to", "came to a", "to a halt"]
      iex> FastNgram.word_ngrams("", 2)
      []
      iex> FastNgram.word_ngrams("some words here", 1)
      ["some", "words", "here"]
  """
  @spec word_ngrams(String.t(), non_neg_integer) :: list
  def word_ngrams(string, 1) do
    String.split(string)
  end

  def word_ngrams(string, n) when is_integer(n) and n > 1 do
    case String.split(string) do
      [] ->
        []

      words ->
        joined = Enum.join(words, " ")
        steps = Enum.map(words, &(byte_size(&1) + 1))

        case initial_window(steps, n, -1) do
          {:ok, len, rest_steps} -> do_sliding_ngrams(joined, 0, len, rest_steps, steps)
          :error -> []
        end
    end
  end
end
