#!/usr/bin/env ruby
require 'rubygems'
require 'mechanize'

def save_bookmarks(mech, email, password)
  mech.get('http://www.tripadvisor.com/MemberSignIn') do |login_page|
    home_page = login_page.form_with(:action => '/MemberSignIn') do |form|
    	form.email    = email
    	form.password = password
    end.click_button
    puts home_page.parser.xpath('/html').to_s
  end
end



# def save_bookmarks(mech, email, password)
#   mech.get('http://www.tripadvisor.com/') do |login_page|
#     home_page = login_page.form_with(:action => '/login?return_url=%2Fla') do |form|
#       form.email = email
#       form.password = password
#     end.click_button
#     about_page = home_page.link_with(:text => 'About Me').click
#     print 'scraping... '
#     bookmarks_page = about_page.link_with(:text => 'Bookmarks').click
#     page_num = 0
#     print "writing page #{page_num}\n"
#     write_bookmarks(bookmarks_page, page_num)
#     loop do
#       break if not bookmarks_page.link_with(:text => 'Next')
#       print 'scraping... '
#       bookmarks_page = bookmarks_page.link_with(:text => 'Next').click
#       page_num += 1
#       print "writing page #{page_num}\n"
#       write_bookmarks(bookmarks_page, page_num)
#       print 'sleeping... '
#       sleep(15)
#     end
#   end
#   puts 'Done'
# end

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

email, password = read_email_password()
save_bookmarks(mech(), email, password)

# End of script

