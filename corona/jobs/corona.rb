require 'net/http'
require 'uri'
require 'json'

#Districnummer zu finden unter https://api.corona-zahlen.org/districts (Mittels STRG+F nach den Ort suchen)
district = '03403'

SCHEDULER.every '60m', :first_in => 0 do |job|

uri = URI.parse("https://api.corona-zahlen.org/districts/"+district)
response = Net::HTTP.get(uri)
data = JSON.parse(response)

inzidenz = data['data'][district]['weekIncidence']
inzidenzRound = inzidenz.to_f.round(2)
name = data['data'][district]['name']

send_event('inci', { :inzidenz => inzidenzRound,
                    :title => 'Inzidenz ' + name })
end