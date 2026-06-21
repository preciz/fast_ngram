# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.3.0] - 2026-06-21

### Added
- Formatted the codebase to ensure consistency with Elixir's style guidelines.

### Optimized
- Significant performance optimization for `FastNgram.word_ngrams/2` using a single-pass `Enum.join/2` followed by a zero-copy sliding window slice with `binary_part/3`.
- Performance optimization for `FastNgram.letter_ngrams/2` for non-ASCII (Unicode) inputs by pre-calculating grapheme sizes and traversing with `binary_part/3` zero-copy slicing.

### Changed
- Bumped dependencies (e.g. `benchee` from `1.5.0` to `1.5.1`).

## [1.2.2] - 2025-12-19

### Optimized
- Speed up `letter_ngrams` with new implementation.

## [1.2.1] - 2025-12-18

### Added
- Add `benchee` to dev dependencies.
- Add more test cases.

### Changed
- Update `ex_doc` and other internal dependency updates.

## [1.1.0] - 2019-10-07

### Added
- Implement `word_ngrams/2` for word-level N-gram extraction.

## [1.0.0] - 2019-10-07

### Added
- Initial release with `letter_ngrams/2` support.
