class RenameMp3
  def rename artist, options
    Dir.glob "./*.mp3" do |file_path|
      filename = File.basename file_path
      cut_filename = filename.slice options[:header], filename.length
      out_filename = artist + ' - ' + cut_filename
      puts out_filename.colorize :yellow
      File.rename filename, out_filename
    end
  end
  def fix options
    Dir.glob "./*.mp3" do |file_path|
      filename = File.basename file_path
      artist = filename.split(' ')[0]
      cut_filename = filename.slice options[:header] + artist.length, filename.length
      out_filename = artist + ' - ' + cut_filename
      puts out_filename.colorize :green
      File.rename filename, out_filename
    end
  end
end
