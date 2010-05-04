require 'open-uri'

HEROKU_URL   = "http://foobar.heroku.com"
FTP_URL      = "ftp://myserver.com/voicemail/"
FTP_USERNAME = "chunky"
FTP_PASSWORD = "bacon"

answer

timestamp = Time.now.strftime("%Y-%m-%d_%H-%M-%S")

open(HEROKU_URL + '/voicemail?phone_number=' + $currentCall.callerID)

record_options = {
  :beep                => true,
  :maxTime             => 60,
  :silenceTimeout      => 2,
  :recordUser          => FTP_USERNAME,
  :recordPassword      => FTP_PASSWORD,
  :recordURI           => FTP_URL + timestamp + '.wav',
  :transcriptionID     => timestamp,
  :transcriptionOutURI => HEROKU_URL + '/transcript'
}

record 'Please leave your message after the tone', record_options
hangup
