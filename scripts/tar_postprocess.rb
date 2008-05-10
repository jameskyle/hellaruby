#!/usr/bin/ruby -w
# Hellanzb post processing script, will delete the files if they failed
# and replace them with a directory named "#{archive_name}_FAILED"
# otherwise, it'll take the directory contents and put them into a single file
# Further, it will *only* do this if the contents of the file are directories
# to save unnecessary processing time.
require 'fileutils'

type = ARGV[0]
archive_name = ARGV[1]
dest_dir = ARGV[2]
elapsed_time = ARGV[3]
par_message = ARGV[4]

if type.eql?('ERROR') then
  FileUtils.rm_rf dest_dir+"/"+archive_name
  FileUtils.mkdir(dest_dir+"/#{archive_name}_FAILED")
elsif type.eql?("SUCCESS") then
  entries = Dir.entries(dest_dir).delete_if {|e| e.match(/^\./)}
  entries.each do |d|
    if File.directory?(d) then
      infile = (dest_dir+"/"+d)
      outfile =(dest_dir+"/"+d+".tar")
      command = "/usr/bin/tar cf \"#{outfile}\" \"#{infile}\""
      if(system(command))
        FileUtils.rm_rf infile
      else
        FileUtils.mv outfile, "#{outfile}.failed"
      end
    end
  end
end
