class RenameMp3
  def rename artist, options
    Dir.glob "./*.mp3" do |file_path|
      filename = File.basename file_path
      cut_filename = filename.slice options[:header], filename.length
      File.rename filename, artist + ' - ' + cut_filename
    end
  end
end
