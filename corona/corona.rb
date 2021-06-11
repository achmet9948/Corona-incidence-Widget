require 'net/http'
require 'uri'
require 'json'

#Districnummer finden unter https://api.corona-zahlen.org/districts (Mittels STRG+F nach den Ort suchen)
district = '03403'

SCHEDULER.every '1m', :first_in => 0 do |job|

uri = URI.parse("https://api.corona-zahlen.org/districts/"+district)
response = Net::HTTP.get(uri)
data = JSON.parse(response)

inzidenz = data['data'][district]['weekIncidence']
name = data['data'][district]['name']

send_event('inci', { :inzidenz => inzidenz.to_i.round(2),
                     :title => 'Inzidenz ' + name })
end