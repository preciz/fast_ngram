# FastNgram

[![test](https://github.com/preciz/fast_ngram/actions/workflows/test.yml/badge.svg)](https://github.com/preciz/fast_ngram/actions/workflows/test.yml)

A fast and unicode aware letter & word N-gram library written in Elixir.

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
iex> FastNgram.letter_ngrams("abcde", 2)
["ab", "bc", "cd", "de"]
iex> FastNgram.letter_ngrams("¥ · € · $", 3)
["¥ ·", " · ", "· €", " € ", "€ ·", " · ", "· $"]
iex> FastNgram.letter_ngrams("", 2)
[]
iex> FastNgram.word_ngrams("the bus came to a halt", 2)
["the bus", "bus came", "came to", "to a", "a halt"]
iex> FastNgram.word_ngrams("the bus came to a halt", 3)
["the bus came", "bus came to", "came to a", "to a halt"]
iex> FastNgram.word_ngrams("", 2)
[]
```

## Documentation

Documentation can be found at [https://hexdocs.pm/fast_ngram](https://hexdocs.pm/fast_ngram).

## License

FastNgram is [MIT licensed](LICENSE).
