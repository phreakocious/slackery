require 'sinatra/base'

module Slackery
  class Web < Sinatra::Base
    get '/' do
      'Slackery at yer service.'
    end
  end
end