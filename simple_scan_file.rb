require 'find'
require 'digest/md5'
require 'byebug'


class Object
  def blank?
    !count.positive?
  end
end

root = ARGV[0] 

unless root and File.directory?(root)
  puts 'directory not found'
  exit
end

file_hash = Hash.new 

start = Time.now
Find.find(root) do |file|
  next unless File.file?(file)
  begin
    file_hash[file] = Digest::MD5.hexdigest(File.read(file))
  rescue
    puts "error reading file #{file} --> MD5 hash not computed."
  end
end

duplicate_content = file_hash.values.group_by{ |e| e }.select { |k, v| v.size > 1 }.map(&:first)
puts 'no duplicate content found' if duplicate_content.blank?

duplicate_content.each do |c|
  duplicate_file = file_hash.select{ |k,v| v == c}

  next if duplicate_file.blank?

  puts "#{File.read(duplicate_file.first.first)} - #{duplicate_file.count}"
end
