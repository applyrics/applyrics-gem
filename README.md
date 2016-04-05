# Applyrics
[![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/applyrics/applyrics-gem/blob/master/LICENSE)
[![Build Status](https://img.shields.io/travis/applyrics/applyrics-gem.svg)](https://travis-ci.org/applyrics/applyrics-gem)
[![Coveralls](https://img.shields.io/coveralls/applyrics/applyrics-gem.svg)](https://coveralls.io/github/applyrics/applyrics-gem)
[![Gem](https://img.shields.io/gem/v/applyrics.svg)](http://rubygems.org/gems/applyrics)

Manage your localization with confidence.

## Disclaimer

**This software should be considered _pre-alpha_ and may thus change at any time, be incomplete or contain bugs.**

## Why Applyrics?

Managing translations for mobile projects can be a mess, especially if you are working with multiple platforms.
iOS projects use key-value \*.strings files, Android use xmls, and variables are defined differently.

*Applyrics* removes these obstacles and lets you manage languages using unified json files.

## Status

| Feature   | iOS | Android |
| --------- | --- | --------|
| extract   | :x: | :x:     |
| apply     | :x: | :x:     |

## Installation

Install using ruby gems:

    sudo gem install applyrics --verbose


## Usage

Usually you start out by extracting the strings from an existing project into a json file by running the following command in your projects directory:

    applyrics extract


After you've made changes to the translations you can apply those changes to the projects.
Notice the addition of the *--rebuild* flag. This will ensure that we don't miss any new keys that might have been added.

    applyrics apply --rebuild


### Global flags

| Flag            | Default | Description                  |
| --------------- | ------- | ---------------------------- |
| --verbose       | false   | Output more detailed logs    |
| --rebuild       | false   | Rebuilds strings from source |
| --lang CODE     | *All*   | Language to work with        |
| --project PATH  | "./"    | Path to project              |


### Actions

Extract strings from project and create strings.json file
(iOS: :x: Android: :x:)

    applyrics extract


Apply a json language file
(iOS: :x: Android: :x:)

    applyrics apply


## License

[MIT](./LICENSE).
