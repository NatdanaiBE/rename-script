# rename-mp3.rb
require 'mp3info'
class RenameMp3
  @@FILE_PATTERNS = ['./*.mp3', './*.m4a']
  def rename(artist, options)
    @@FILE_PATTERNS.each do |pattern|
      Dir.glob pattern do |file_path|
        filename = File.basename file_path
        cut_filename = filename.slice options[:header], filename.length
        out_filename = artist + ' - ' + cut_filename
        puts out_filename.colorize :yellow
        File.rename filename, out_filename
      end
    end
  end

  def fix(options)
    Dir.glob './*.mp3' do |file_path|
      filename = File.basename file_path
      artist = filename.split(' ')[0]
      cut_filename = filename.slice options[:header] + artist.length, filename.length
      out_filename = artist + ' - ' + cut_filename
      puts out_filename.colorize :green
      File.rename filename, out_filename
    end
  end

  def mp3info_rename(options)
    @@FILE_PATTERNS.each do |pattern|
      Dir.glob pattern do |file_path|
        old_filename = File.basename file_path
        extension = File.extname old_filename
        Mp3Info.open file_path do |mp3|
          artist = mp3.tag1.artist
          title = mp3.tag1.title
          if not title.nil? and title.match /[uac00-ud7a3]+/ and title.match /[A-Za-z]+/
            title = title.match(/[()]([A-Za-z ]+)[()]/).captures[0]
            new_filename = artist + ' - ' + title + extension
            puts new_filename.colorize :light_magenta
            # new_filename.split('').each do |char|
            #   puts char.ord.to_s.colorize :yellow
            # end
            File.rename old_filename, new_filename
          end
        end
      end
    end
  end

end
