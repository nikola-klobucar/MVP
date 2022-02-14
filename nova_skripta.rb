require 'pry'
require 'faraday'
require 'json'
require 'digest'

time = Time.now.to_i.to_s

req = {
	"id": "385654",
	"transaction_type": "refund",
}

body_as_string = req.to_json
merchent_key = 'key-942fe42f1cdbf1700b5b784532f6181c'
auth_token = 'c70ec12b1c9518bef9859edd75e0012148391ee7'
digest = Digest::SHA2.new(512).hexdigest(merchent_key + time + auth_token + body_as_string)

# ---------------------
# Od ovog dijela radim requestove
# ---------------------


url = 'https://ipgtest.monri.com'

glava = {
    "Content-Type" => "application/json",
    "Content-Length" => body_as_string.length.to_s,
    "Authorization" => "WP3-v2 " + auth_token + " " + time + " " + digest 
}

conn = Faraday.new(
    url: url
)

response = conn.post("transactions/#{req[:id]}/refund", body_as_string, glava)

binding.pry


