require 'csv';
require 'optparse'

## Options

options = {}
OptionParser.new do |parser|
    parser.banner = "Usage: go.rb -i <file.csv> -o <DIR>"
    parser.on("-i FILENAME", "CSV file to read from")
    parser.on("-o DIR", "Directory into which to dump the files")
end.parse!(into:options)

inputFile = options[:i]
outDIR = options[:o]
if (!inputFile || !outDIR) then
    puts "Missing option.  Run go.rb -h for help"
    exit
end
if (!outDIR.end_with?("/")) 
    outDIR = outDIR + "/"
end

## Here we go

previousTitle = ""
filename = 0
outFile = nil

def writeOut(file, text) 
    file.write(text)
    file.write("\n")
end

def dumpItem(file, note, content) 
    writeOut file, "Note: #{note}" if note
    writeOut file, "#{content}" if content
end

CSV.foreach(inputFile, headers: true) do |row|
    title = row["Title"]
    author = row["Author"]
    created = row["Created"]
    location = row["Located"]
    content = row["Content"]
    note = row["Notes"]

    if (title == previousTitle) then
        # Adding to the same book
        writeOut outFile, "\n---\n"
    else
        # Starting a new book, so end previous book
        writeOut outFile, "\n#imported/clippings" if outFile
        outFile.close() if outFile
        # and start the next
        filename = filename + 1
        outFile = File.new("#{outDIR}#{filename}.txt","w")
        previousTitle = title
        writeOut outFile, "\# #{title}"
        writeOut outFile, "#{author}"
        writeOut outFile, "#{created}\n\n" # not ideal, just a single date.
    end

    dumpItem(outFile, note, content)
end

outFile.close() if outFile