begin
  # Require the preresolved locked set of gems.
  require ::File.expand_path('../.bundle/environment', __FILE__)
rescue LoadError
  # Fallback on doing the resolve at runtime.
  require 'rubygems'
  require 'bundler'
  Bundler.setup
end

require 'sinatra'
require 'pony'
require 'whitepages_lookup'


configure do
  SENDGRID_CONFIG = {
    :address        => 'smtp.sendgrid.net',
    :port           => 25,
    :authentication => :plain,
    :user_name      => ENV['SENDGRID_USERNAME'],
    :password       => ENV['SENDGRID_PASSWORD'],
    :domain         => ENV['SENDGRID_DOMAIN']
  }
end

helpers do
  def mail(subject, body)
    Pony.mail(:from => ENV['SENDGRID_USERNAME'], :to => ENV['EMAIL'], :via => :smtp, :via_options => SENDGRID_CONFIG, :subject => subject, :body => body)
  end
end

get '/voicemail' do
  @@last_voicemail_cid = params[:phone_number]
end

post '/transcript' do
  transcript_xml = Nokogiri::XML(request.body.read)
  identifier = transcript_xml.at_xpath('//identifier').inner_text
  transcript = transcript_xml.at_xpath('//transcription').inner_text
  cnam = Whitepages.lookup(@@last_voicemail_cid)
  body = "From: #{cnam} <#{@@last_voicemail_cid}>\n\n#{transcript}\n\nAudio Link: #{ENV['VOICEMAIL_URL'] + identifier}.wav"
  mail("New voicemail from #{cnam}", body)
end
