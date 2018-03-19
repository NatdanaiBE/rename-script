require 'colorize'
require 'pathname'
require 'pp'
require 'thor'
require 'terminal-table'


require_lists = ['rename-mp3']
root_script_dir = nil
thor_root_yml = Pathname.new(File.expand_path __FILE__).dirname.join 'thor.yml'
if thor_root_yml.file?
  thor_yml_data = YAML.load thor_root_yml.read
  thor_yml_data.each do |_thor_name, config|
    if config[:filename] == Pathname.new(__FILE__).basename.to_s
      root_script_dir = Pathname.new(config[:location]).dirname
    end
  end
else
  root_script_dir = Pathname.new(File.expand_path __FILE__).dirname
end

if root_script_dir.nil?
  abort 'Please contact administrator.!'.red
else
  require_lists.map{|e| root_script_dir.join e }.each{|name| require name }
end

class Rename < Thor
  desc 'mp3 ARTIST', 'Rename all .mp3s in directory'
  long_desc <<-LONGDESC
    Rename all .mp3s, .wmas, .m4as and .accs in directory
  LONGDESC
  method_option :header, aliases: '-h', type: :numeric, desc: 'header substring length', default: 0
  
  def mp3(artist)
    RenameMp3.new.rename artist, options
    puts 'Complete'.colorize :red
  end
  desc 'fix', 'Fix all over-renamed .mp3s in directory'
  long_desc <<-LONGDESC
    Fix all .mp3s, .wmas, .m4as and .accs in directory
  LONGDESC
  method_option :header, aliases: '-h', type: :numeric, desc: 'header substring length', default: 0

  def fix
    RenameMp3.new.fix options
    puts 'Complete'.colorize :blue
  end

  desc 'test', 'This is just for test'
  long_desc <<-LONGDESC
    This is just for test
  LONGDESC

  def test
    puts 'This is just for test'
    RenameMp3.new.mp3info_rename options
  end
end