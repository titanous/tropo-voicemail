# Tropo Voicemail

This app is designed to replace your GSM phone's voicemail. Instead of a
phone-based voicemail inbox, messages are transcribed and emailed with a link
to the audio file.

Please note that I only spent a few hours writing this, so there may be bugs,
and it's just a starting point that could be developed a lot further.

## Requirements

* [Heroku](http://heroku.com) account
* [Tropo](http://www.tropo.com) account
* FTP server with HTTP access
* GSM phone with call forwarding

## Setup

### Heroku

    git clone git@github.com:titanous/tropo-voicemail.git
    cd tropo-voicemail
    heroku create
    heroku addons:add sendgrid:free
    heroku config:add EMAIL=you@email.com
    heroku config:add VOICEMAIL_URL=http://yourserver.com/voicemail/
    git push heroku master

### Tropo

Create a new application on Tropo, and point it to a new Hosted File with the
contents of `tropo-voicemail.rb`. Make sure you change the constants at the top
of the file to be real values. The FTP URL may not match the HTTP URL given
above (you may need a `public_html`).

You now have two options. If you are in the US, then you can add a free USA
Domestic number. Note that you probably want a number in your local calling
area. If you aren't in the US or couldn't find a local number on Tropo, then you
should get a SIP DID from a company like [Voip.ms](http://voip.ms/) and forward
it to the Tropo SIP URI.

### Cell Phone

The last step is to use some GSM feature codes to setup conditional call
forwarding. Dial each of these numbers on your cell phone and press Send:

    *67*TROPO_PHONE_NUMBER# (forward if busy)
    *61*TROPO_PHONE_NUMBER# (forward if not answered)
    *62*TROPO_PHONE_NUMBER# (forward if out of reach)

The phone should show a message after each that says something about the
conditional call foward being set. If for any reason you need to disable these
forwards, use these codes:

    ##67#
    ##61#
    ##62#

## Copyright

(c) 2010 Jonathan Rudenberg; Licensed under the MIT license, see `LICENSE`
