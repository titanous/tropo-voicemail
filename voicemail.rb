require 'sinatra'
require 'whitepages_lookup'
require 'logger'

configure do
  LOGGER = Logger.new('log/sinatra.log')
end

helpers do
  def log
    LOGGER
  end
end

post '/voicemail' do
  log.info params
end

post '/transcript' do
  log.info params
end
