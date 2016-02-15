#!/usr/bin/env ruby

# This script enables 'Natural scrolling' on <device>
#
# License: GPL
# Author: Marcel Hild <hild@b4mad.net>

def device_name
  @device_name ||= ARGV[0]
end

def input_ids
  devices = `xinput list --short`
  devices.lines.grep(/#{device_name}/i).map do |line|
    line.match(/(.*?)\tid=(\d+)/)[1..2]
  end
end

unless device_name
  puts "#{File.basename($PROGRAM_NAME)} <device>\n\n"
  puts `xinput list --name-only | sort | uniq`
  exit 1
end

input_ids.each do |name, id|
  puts name
  cmd = "xinput set-prop #{id} 'libinput Natural Scrolling Enabled' 1"
  puts cmd
  `#{cmd}`
end
