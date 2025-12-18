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
    case take_graphemes(string, n - 1, []) do
      {initial, rest} -> do_letter_ngrams(rest, initial, n)
      _ -> []
    end
  end

  defp do_letter_ngrams(rest, window, n) do
    case String.next_grapheme(rest) do
      {g, next_rest} ->
        new_full_window = window ++ [g]
        ngram = IO.iodata_to_binary(new_full_window)
        [ngram | do_letter_ngrams(next_rest, tl(new_full_window), n)]

      nil ->
        []
    end
  end

  defp take_graphemes(str, 0, acc), do: {Enum.reverse(acc), str}

  defp take_graphemes(str, k, acc) do
    case String.next_grapheme(str) do
      {g, rest} -> take_graphemes(rest, k - 1, [g | acc])
      nil -> nil
    end
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
    string |> String.split()
  end

  def word_ngrams(string, n) when is_integer(n) and n > 0 do
    words = string |> String.split()

    do_word_ngrams(n, length(words), words)
  end

  defp do_word_ngrams(n, len, words) when len >= n do
    [Enum.take(words, n) |> Enum.join(" ") | do_word_ngrams(n, len - 1, tl(words))]
  end

  defp do_word_ngrams(_, _, _) do
    []
  end
end
