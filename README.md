# FastNgram

A fast and unicode aware letter N-gram library written in Elixir.

## Installation

The package can be installed by adding `fast_ngram` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:fast_ngram, "~> 1.0"}
  ]
end
```

## Usage
```elixir
iex> FastNgram.letter_ngrams("¥ · € · $", 3)
["¥ ·", " · ", "· €", " € ", "€ ·", " · ", "· $"]
iex> FastNgram.letter_ngrams("", 2)
[]
iex> FastNgram.letter_ngrams("abcd", 1)
["a", "b", "c", "d"]
iex> FastNgram.letter_ngrams("abcde", 2)
["ab", "bc", "cd", "de"]
```

Documentation can be be found at [https://hexdocs.pm/fast_ngram](https://hexdocs.pm/fast_ngram).

