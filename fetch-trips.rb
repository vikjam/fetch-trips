#!/usr/bin/env ruby
require 'rubygems'
require 'mechanize'

def mech()
  Mechanize.new do |agent|
      agent.user_agent_alias = 'Mac Safari'
      agent.follow_meta_refresh = true
  end
end

def write_bookmarks(page, page_num)
  source = page.parser.xpath('/html').to_s
  File.open("bookmark#{page_num}.html", 'w') do |f|
    f.write(source)
  end
end

def read_email_password()
  print 'Enter email: '
  email = STDIN.readline()
  print 'Enter password: '
  system 'stty -echo'
  password = STDIN.readline()
  system 'stty echo'
  return email.chomp!, password.chomp!
end

read_email_password()

# End of script

