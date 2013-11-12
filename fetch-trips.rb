#!/usr/bin/env ruby -w

require 'mechanize'

def mech()
    Mechanize.new do |agent|
        agent.user_agent_alias = 'Mac Safari'
        agent.follow_meta_refresh = true
        agent.open_timeout = 60
        agent.read_timeout = 60
    end
end

# End of script

