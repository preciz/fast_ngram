defmodule FastNgram do
  @moduledoc """
  A fast and unicode aware letter N-gram library written in Elixir.
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
    n_gram = graphemes |> Enum.take(n)

    case length(n_gram) == n do
      true ->
        [n_gram |> :binary.list_to_bin() | do_letter_ngrams(tl(graphemes), n)]

      false ->
        []
    end
  end
end
