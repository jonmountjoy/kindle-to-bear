# Kindle Highlights => Clippings.io => Bear

## Steps

1. Make your book highlights on your Kindle or Kindle app
2. Import them into Clippings.io
3. Export them as Excel 2007
4. Open the spreadsheet locally, and export as CSV
5. Run this app to create a set of files for each book.
6. Bear -> File -> Import Notes.  Select all the notes. Select "Use first line as title".
7. Done

## How to run

    ruby go.rb -i /tmp/clippings.csv -o /tmp/out

## Usage

    Usage: go.rb -i <file.csv> -o <DIR>
    -i FILENAME                      CSV file to read from
    -o DIR                           Directory into which to dump the files

## TODO

1. Avoid the CSV step and make this app read the spreadsheet instead.
2. I use Clippings.io for convenience.  Is there a library to use instead?
