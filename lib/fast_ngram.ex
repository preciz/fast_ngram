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
  def letter_ngrams(string, n) when is_integer(n) and n > 0 do
    graphemes = string |> String.graphemes()

    do_letter_ngrams(graphemes, n)
  end

  defp do_letter_ngrams(graphemes, n) do
    ngram = graphemes |> Enum.take(n)

    case length(ngram) == n do
      true ->
        [ngram |> :binary.list_to_bin() | do_letter_ngrams(tl(graphemes), n)]

      false ->
        []
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
  """
  def word_ngrams(string, n) when is_integer(n) and n > 0 do
    words = string |> String.split()

    do_word_ngrams(words, n)
  end

  defp do_word_ngrams(words, n) do
    ngram = words |> Enum.take(n)

    case length(ngram) == n do
      true ->
        [ngram |> Enum.join(" ") | do_word_ngrams(tl(words), n)]

      false ->
        []
    end
  end
end
