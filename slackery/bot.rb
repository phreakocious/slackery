module Slackery

  class Bot < SlackRubyBot::Bot
    puts "\n\nslackery running with environment '#{ENVIRONMENT}'\n\n"

    SlackRubyBot::Client.logger.level = Logger::WARN

    config = YAML.load_file CONFIG_YML rescue abort "Error loading main config at #{CONFIG_YML}."
    config = config[ENVIRONMENT].symbolize_keys
    puts "loaded config #{CONFIG_YML}"

    DataMapper::Logger.new(File.open(config[:db_log], 'w'))
    puts "Database logging to #{config[:db_log]}"

    DataMapper.setup(:default, config[:db_url])
    puts "Database setup complete for #{config[:db_url]}"

    #users = Hash[self.client.users_list['members'].map { |m| [m['id'], m['name']] } ]
    #channels = Hash[client.channels_list['channels'].map { |c| [c['id'], c['name']] } ]
    #watched_channels = config[:channels].map { |c| channels.key c }

  end
end


#TODO: ADD A TICKET TO ASSEMBLA
#TODO: map a command to a function if on exists with a prefix..... ?puts == __puts
#TODO: create a way to add tables to the DB for your thing
#TODO: aliases (ln -s?)
#TODO: follow twitter people with new posts in channel
#TODO: same for something like RSS?
#TODO: browser plugin to add links to channel?
#TODO: whois
#TODO: don't allow running as root
#TODO: find a way to prevent shelling out for random stuff added by users


