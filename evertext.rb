require 'nokogiri'

my_notes_dir = File.expand_path(ARGV[0])

Dir.chdir(my_notes_dir)
Dir.chdir("..")
Dir.mkdir("evertextfiles") unless File.directory?("evertextfiles")
evertextfiles_dir = File.expand_path("evertextfiles")
Dir.chdir(my_notes_dir)
Dir.glob("*.html") do |filename|
  Dir.chdir(my_notes_dir)
  new_filename = filename.sub(".html", "") + ".txt"
  File.open(filename, "r") do |f|
    html = Nokogiri::HTML(IO.read filename)
    text = html.at('body').inner_text
    Dir.chdir(evertextfiles_dir)
    File.open(new_filename, "w") do |new_file|
      new_file.puts text
    end
  end
end