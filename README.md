
# Nilpart USAGE

You need a Partoo.co Api-Key.

## Initialize Nilpart

 np = Nilpart::Nilpart.new({ api_key: YOUR_API_KEY, mode: "production" }) # mode must be 'production' or 'sandbox'

## Example of data returned

 np.businesses_search.first.dig('businesses',0,'name') # name of business
 np.businesses_search.first.dig('businesses',0,'city') # City
 np.businesses_search.first.dig('businesses',0,'zipcode') # Postcode
 np.businesses_search.first.dig('businesses',0,'address2')
 np.businesses_search.first.dig('businesses',0,'address_details','street_type')
 np.businesses_search.first.dig('businesses',0,'address_details','street_name')
 np.businesses_search.first.dig('businesses',0,'contacts',0,'phone_numbers')
 np.businesses_search.first.dig('businesses',0,'contacts',0,'email')
    
## Open hours

 np.businesses_search.first.dig('businesses',0,'open_hours')
 np.businesses_search.first.dig('businesses',0,'open_hours','monday')
 np.businesses_search.first.dig('businesses',0,'open_hours','tuesday')
 np.businesses_search.first.dig('businesses',0,'open_hours','wednesday')
 np.businesses_search.first.dig('businesses',0,'open_hours','thursday')
 np.businesses_search.first.dig('businesses',0,'open_hours','friday')
 np.businesses_search.first.dig('businesses',0,'open_hours','saturday')
 np.businesses_search.first.dig('businesses',0,'open_hours','sunday')
 
## More ?

See available methods here : https://github.com/rivsc/nilpart/blob/main/lib/nilpart/nilpart.rb