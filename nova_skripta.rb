require 'pry'
require 'faraday'
require 'json'
require 'digest'
require "active_support/all"

time = Time.now.to_i.to_s

req = {
    "id": "385654",
	"order_number": "e5a9929065ee860e9d221644844371",
	"transaction_type": "refund",
    "authenticity-token": 'c70ec12b1c9518bef9859edd75e0012148391ee7',
    "amount": "943",
    "currency": "EUR"
}


merchent_key = 'key-942fe42f1cdbf1700b5b784532f6181c'
auth_token = 'c70ec12b1c9518bef9859edd75e0012148391ee7'
digest = Digest::SHA1.new.hexdigest(merchent_key + req[:order_number] + req[:amount] + req[:currency])

req[:digest] = digest
body_as_xml = req.to_xml(:root => 'transaction')

# ---------------------
# Doing requests after this line
# ---------------------


url = 'https://ipgtest.monri.com'

glava = {
    "Content-Type" => "application/xml",
    "Content-Length" => body_as_xml.length.to_s,
    "Authorization" => "WP3-v2 " + auth_token + " " + time + " " + digest 
}

conn = Faraday.new(
    url: url
)

response = conn.post("transactions/#{req[:id]}/refund.xml", body_as_xml, glava)
