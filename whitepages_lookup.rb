require 'open-uri'
require 'nokogiri'

class Whitepages

  BASE_URL = 'http://api.whitepages.com/reverse_phone/1.0/?api_key=961afce4a5e945067a2def638a63968d&phone='

  def self.lookup(phone_number)
    result = Nokogiri::XML(open(BASE_URL + phone_number))

    if result.at_xpath('//wp:phone')
      case result.at_xpath('//wp:phone').attributes['type'].value
      when 'landline'
        result.at_xpath('//wp:displayname').inner_text
      when 'mobile'
        'Cell Phone'
      end
    end
  end

end
