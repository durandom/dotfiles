#!/usr/bin/env ruby

require 'mini_exiftool'

ARGV.shift if $dry_run = ARGV[0] == '-n'

def set_date(filename, touch_time)
  # "mm/dd/[yy]yy [hh:mm:[:ss] [AM | PM]]"
  %w(-d -m).each do |arg|
    cmd = %Q(SetFile #{arg} "#{touch_time.strftime('%m/%d/%Y %H:%M:%S')}" "#{filename}")
    puts cmd
    system cmd
  end
end

sep = '[-._]'
prev_time = nil
counter = 0

ARGV.each do |filename|
  year, month, day, title = nil
  if m = filename.match(/^(\d{4})#{sep}(\d{2})#{sep}(\d{2})\D/)
    year, month, day = m[1..3]
  elsif m = filename.match(/^(\d{4})#{sep}(\d{2})\D/)
    year, month = m[1..3]
  elsif m = filename.match(/^(\d{4})\D/)
    year = m[1]
  end

  if match = filename.match(/[0-9_-]*(.*)\.jpg$/)
    puts title = match[1]
    title = %Q(-title="#{title.gsub(/([_-]?\d+)$/, '').strip}")
    # photo = MiniExiftool.new(filename)
    # puts photo.title
  end

  raise "no time for #{filename}" unless year

  time = Time.mktime(year, month, day)
  if time == prev_time
    counter += 1
  else
    counter = 0
  end
  prev_time = time

  touch_time = time + counter
  puts "#{touch_time} - #{filename}"
  set_date(filename, touch_time) unless $dry_run
  cmd = %Q(exiftool -P -overwrite_original #{title} "-FileModifyDate>AllDates" "#{filename}")
  puts cmd
  system cmd unless $dry_run
  set_date(filename, touch_time) unless $dry_run

end
