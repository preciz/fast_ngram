defmodule FastNgramTest do
  use ExUnit.Case
  doctest FastNgram

  describe "letter_ngrams/2" do
    test "returns graphemes when n is 1" do
      assert FastNgram.letter_ngrams("abc", 1) == ["a", "b", "c"]
    end

    test "returns empty list for empty string when n is 1" do
      assert FastNgram.letter_ngrams("", 1) == []
    end

    test "returns 2-grams correctly" do
      assert FastNgram.letter_ngrams("abc", 2) == ["ab", "bc"]
    end

    test "returns n-grams for unicode characters" do
      # Each of these is a single grapheme
      str = "aéñ👍"
      assert FastNgram.letter_ngrams(str, 2) == ["aé", "éñ", "ñ👍"]
    end

    test "returns empty list when n is larger than string length" do
      assert FastNgram.letter_ngrams("abc", 4) == []
    end

    test "returns single n-gram when n equals string length" do
      assert FastNgram.letter_ngrams("abc", 3) == ["abc"]
    end

    test "handles whitespace correctly" do
      assert FastNgram.letter_ngrams("a b", 2) == ["a ", " b"]
    end
  end

  describe "word_ngrams/2" do
    test "returns individual words when n is 1" do
      assert FastNgram.word_ngrams("one two three", 1) == ["one", "two", "three"]
    end

    test "handles multiple spaces between words" do
      assert FastNgram.word_ngrams("one   two", 1) == ["one", "two"]
    end

    test "returns 2-grams of words" do
      assert FastNgram.word_ngrams("one two three", 2) == ["one two", "two three"]
    end

    test "returns empty list when n is larger than word count" do
      assert FastNgram.word_ngrams("one two", 3) == []
    end

    test "returns single n-gram when n equals word count" do
      assert FastNgram.word_ngrams("one two", 2) == ["one two"]
    end

    test "returns empty list for empty string" do
      assert FastNgram.word_ngrams("", 2) == []
    end

    test "returns empty list for string with only whitespace" do
      assert FastNgram.word_ngrams("   ", 2) == []
    end
  end
end
