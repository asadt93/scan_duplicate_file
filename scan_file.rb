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
puts " ========= found #{duplicate_content.count} duplicate content ============"

puts 'no duplicate content found' if duplicate_content.blank?

i = 0
duplicate_content.each do |c|
  duplicate_file = file_hash.select{ |k,v| v == c}
  
  next if duplicate_file.blank?
  
  puts "#{i+=1}) - #{duplicate_file.count} duplicate files"

  duplicate_file.each do |df|
    puts "-- #{df.first}"
  end
end

finish = Time.now
diff = (finish - start) * 1000.0
puts "\n\n"
puts "execution time :    #{diff.round} ms"
puts "total file     :    #{file_hash.count}"