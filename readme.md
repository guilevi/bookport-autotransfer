# BookPort auto-transfer

This repository includes a [Hammerspoon](http://hammerspoon.org/) script and a shell script to automate transferring books in any text format to an APH BookPort.

It requires [the Unix Book Transfer tool](http://www.nfbcal.org/~buhrow/ubt/).

To use the bport shell script, you must also have the ebook-convert command from [Calibre](https://calibre-ebook.com/)

### Installation

* Make sure UBT is in your path
* Run install.sh. This will install:
	* ~/.hammerspoon/bookport.lua: The hammerspoon code for automatic book transfer
	* /usr/local/bport: The shell script for quickly transferring straight from Epub
	* ~/.bport/rules: Necessary directory for bport and rules file for pronunciation fixes with a few examples
* Add `require('bookport')`to your Hammerspoons init.lua

### Usage

Bookport.lua implements automatic transfer of book files to a BookPort while it is connected to a computer through USB. The first two lines of the script allow you to change the path of the BookPort volume and the queue directory which will be watched for new books. The default TTS engine will be used to inform of activity.

The bport shell script automatically converts a book using Calibre ebook-convert, allows you to change the first line (which BookPort treats as the book title) and produces ._DD and ._IX files using UBT. The location of the resulting files depends on your UBT configuration.

If the UBT queue directory and the bookport.lua queue directory are equal, while a BookPort is connected, it is possible to transfer a book to it straight from an Epub file by running bport on it.

The ~/.bport/rules file contains SED expressions which will be applied to the book text when using bport. This allows you to have a pronunciation dictionary of sorts. I have included a few examples from several books.

