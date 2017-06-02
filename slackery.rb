
CONFIG_YML = 'config.yml'
DBCONFIG_YML = 'db/config.yml'
#ENVIRONMENT = ARGV.shift          #TODO: Fix environment handling
ENVIRONMENT = 'development'

require 'pp'
require 'yaml'
require 'sqlite3'
require 'data_mapper'
require 'dm-timestamps'
require 'slack-ruby-bot'
require 'active_support/hash_with_indifferent_access'  # symbolize_keys...

require 'slackery/commands'
require 'slackery/bot'             # sets up DataMapper for the database
require 'slackery/models'          # must come last -- needs DataMapper

Slackery::Commands::Memories.first_or_create(keyword: 'slackery', memory: 'huh?')
