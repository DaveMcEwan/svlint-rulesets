
svlint-rulesets
===============

A collection of pre-configured rulsets for svlint and svls, with corresponding
wrapper scripts.


Installation
------------

1. Install [svlint](https://github.com/dalance/svlint) and/or
  [svls](https://github.com/dalance/svls) by any of the supported methods
  (download a pre-built [binary release](https://github.com/dalance/svlint/releases/latest),
  get a published [snap package](https://snapcraft.io/svlint), or build from
  source via [Cargo](https://crates.io/crates/svlint)).
  It doesn't matter how you install svlint, as long as it's in your `$PATH`.
2. Clone this repository to somewhere convenient.
3. (Optional) Place your own ruleset into the `toml` directory.
  It's convenient to use a short and descriptive name, because the next step
  will create a wrapper based on the filename.
  You can create a template ruleset with `svlint --example > toml/foo.toml`.
4. Run `make` to create the wrappers in a new `bin/` directory.
  NOTE: All wrappers are actually the same file, as they are all hardlinks to
  `svlint-wrapperTemplate`.
5. Add `bin/` to your `$PATH`.
  To test that the wrapper scripts have been created correctly, try something
  like `svlint-parseonly -h`.


Rulesets
--------

- parseonly - No rules are enabled.
  Files are pre-processed (dependent on the set of defines) and the resultant
  source text is parsed to create an Abstract Syntax Tree.
  If the source text is invalid SystemVerilog (IEEE 1800-2017), then
  svlint will report a error.
  Due to svlint's implementation, lint rules are not loaded into memory for
  this ruleset.
- functional - Only functional rules are enabled, but none which check for
  style or naming conventions.
  These rules check for syntax that may lead to inconsistency between synthesis
  and simulation, as well as valid-but-unintuitive constructs, e.g. using a
  system-function name as a variable identifier.
- naming - Only rules which check against a naming convention are enabled.
- style - Only rules which check the use of whitespace are enabled.
- ddvc - (WIP) Enforce an draft extension of Nordic's DDVC.


Implementation
--------------

All of the `bin/svlint-*` and `bin/svls-*` scripts created by running `make`
are hardlinks to `wrapperTemplate`.
This means that they are all effectively the same file, and a change to one
will change all of them.

When you run with an explicitly specified path, e.g.
`/path/to/svlint-rulesets/bin/svlint-foo`, the wrapper will figure out where
the corresponding TOML ruleset is located and run
`SVLINT_CONFIG=/path/to/svlint-rulesets/toml/foo.toml svlint`.
Similarly, when you run with an implicitly specified path (because the wrapper
scripts' location in is your `$PATH`), the wrapper will still figure out where
the corresponding TOML ruleset is located.
The method of self-discovery is Bash-specific: `THIS="${BASH_SOURCE[0]:-$0}"`.

