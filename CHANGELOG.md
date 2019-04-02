# CHANGELOG for visualstudio

This file is used to list changes made in each version of visualstudion.

## 1.2.6

* Add test kitchen with test policy and dummy tests
* Fix version in metadata

## 1.2.5

* Added the attribute for additional "success" return codes
* Fix deprecations and formatting
* Backported updated metadata from upstream community cookbook

## 1.2.4

* Allow for overriding install dir on a per-edition basis

## 1.2.3

* Remove Chef::shell_out as it was deprecated replaced with mixin

## 1.2.2

* Make the installers download components from the web when needed

## 1.2.1

* VisualSutdio 2017 now installs cleanly from a web download.
* TODO: Migrate to `dsc_resources` for installs.

## 1.2.0

* Default to VS 2015 Community Edition
* Add ability to specifiy installed features via install_items attributes.
* Add default_source URLs for VS 2013 and 2015, make source attribute optional.
* Add ability to specifiy download source on a per edition/version basis.
* [GH 58](https://github.com/daptiv/visualstudio/issues/58) Fix enable nuget package restore recipe idempotence.
* [GH 56](https://github.com/daptiv/visualstudio/issues/56) Fix architecture check.

## 1.1.0

* VS 2010 installation defaults to /q without needing an unattend.ini file.
* VS 2012 Update 5.
* VS 2015 Enterprise edition added.
* Product key is now configurable via a node attribute.
* Replaced Tailor with RuboCop and upgraded development dependencies.
* Fixed "Win32::Registry::Error".
* Added TravisCI build.

## 1.0.1:

* Exit code 3010 (reboot required) should not fail Chef run
* Fix install_update minitest failure on VS 2015
* Fix VisualStudio 2015 installation error (WebSocket4NetV1) on Windows 2012R2
* Increase VSTO installation timeout from 10m to 30m

## 1.0.0:

* Initial release to Chef SuperMarket

- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
