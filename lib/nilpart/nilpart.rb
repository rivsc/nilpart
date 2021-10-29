require_relative './version'
require 'faraday'
require 'json'

module Nilpart
  class Nilpart
    PRODUCTION_SERVER = "https://api.partoo.co/v2/"
    SANDBOX_SERVER = "https://sandbox.api.partoo.co/v2/"

    attr_accessor :my_api_key
    attr_accessor :production # prod / sandbox

    # +api_key+ your api_key
    # +mode+ "prod" for production / "sandbox" for sandbox
    #
    # np = Nilpart::Nilpart.new({ api_key: "machin", mode: "prod" })
    # np.api_keys
    # np.google_posts_search
    #
    # np.businesses_search({code: '197'}) # get business by code
    # np.businesses_search.first.dig('businesses',0,'name') # nom du commerce
    # np.businesses_search.first.dig('businesses',0,'city')
    # np.businesses_search.first.dig('businesses',0,'zipcode')
    # np.businesses_search.first.dig('businesses',0,'address2') # complément adresse
    # np.businesses_search.first.dig('businesses',0,'address_details','street_type')
    # np.businesses_search.first.dig('businesses',0,'address_details','street_name')
    #
    # np.businesses_search.first.dig('businesses',0,'contacts',0,'phone_numbers')
    # np.businesses_search.first.dig('businesses',0,'contacts',0,'email')
    #
    # np.businesses_search.first.dig('businesses',0,'open_hours')
    # np.businesses_search.first.dig('businesses',0,'open_hours','monday')
    # np.businesses_search.first.dig('businesses',0,'open_hours','tuesday')
    # np.businesses_search.first.dig('businesses',0,'open_hours','wednesday')
    # np.businesses_search.first.dig('businesses',0,'open_hours','thursday')
    # np.businesses_search.first.dig('businesses',0,'open_hours','friday')
    # np.businesses_search.first.dig('businesses',0,'open_hours','saturday')
    # np.businesses_search.first.dig('businesses',0,'open_hours','sunday')
    #
    def initialize(params)
      @my_api_key = params[:api_key]

      raise ':api_key is required !' if @my_api_key.to_s.empty?
      raise ':mode params must be "prod" or "sandbox"' unless ['prod', 'sandbox'].include?(params[:mode])

      @production = params[:mode].to_s == 'prod'
    end

    def server_url
      @production ? PRODUCTION_SERVER : SANDBOX_SERVER
    end

    def get_request(path, params = {})
      response = Faraday.get("#{self.server_url}#{path}", params, { 'x-APIKey' => @my_api_key })
      if response.status != 200 # Faraday has not constante for status 200
        puts "#{__method__} : Path => #{path} : Status => #{response.status}"
      end
      return JSON.parse(response.body)
    end

    def delete_request(path, params = {})
      response = Faraday.delete("#{self.server_url}#{path}", params, { 'x-APIKey' => @my_api_key })
      if response.status != 200 # Faraday has not constante for status 200
        puts "#{__method__} : Path => #{path} : Status => #{response.status}"
      end
      return JSON.parse(response.body)
    end

    def post_request(path, body = {})
      response = Faraday.post("#{self.server_url}#{path}", body.to_json, { 'x-APIKey' => @my_api_key, "Content-Type" => "application/json" })
      if response.status != 200 # Faraday has not constante for status 200
        puts "#{__method__} : Path => #{path} : Status => #{response.status}"
      end
      return JSON.parse(response.body)
    end

    def put_request(path, body = {})
      response = Faraday.put("#{self.server_url}#{path}", body.to_json, { 'x-APIKey' => @my_api_key, "Content-Type" => "application/json" })
      if response.status != 200 # Faraday has not constante for status 200
        puts "#{__method__} : Path => #{path} : Status => #{response.status}"
      end
      return JSON.parse(response.body)
    end

    ##########################################
    ##########################################
    #         Map Partoo RestAPI             #
    ##########################################
    ##########################################

    ##############
    # Api-Key
    ##############

    def api_keys(params = {})
      get_request('api_keys', params)
    end

    def api_key_get(id)
      get_request("api_keys/#{id}")
    end

    def api_key_update(id, params = {})
      put_request("api_keys/#{id}", params)
    end

    def api_key_revoke(id)
      post_request("api_keys/revoke/#{id}")
    end

    ####################
    # Connection Tokens
    ####################

    def connection_generate_token(params = {})
      post_request("connection/generate_token", params)
    end

    def connection_revoke_token(params = {})
      post_request("connection/revoke_token", params)
    end

    def connection_check_token(params = {})
      get_request("connection/check_token", params)
    end

    ####################
    # ORGANISATION
    ####################

    def organisation_search(params = {})
      get_request("org/search", params)
    end

    def organisation_get(id)
      get_request("org/#{id}")
    end

    def organisation_create(params = {})
      post_request("org", params)
    end

    def organisation_update(id, params = {})
      post_request("org/#{id}", params)
    end

    def organisation_delete(id, params = {})
      delete_request("org/#{id}", params)
    end

    ################
    # BUSINESS
    ################

    def businesses_search(params = {})
      get_request("business/search", params)
    end

    def business_create(params = {})
      post_request("business", params)
    end

    def business_connections_stats
      get_request("business/connections_stats")
    end

    def business_get(id)
      get_request("business/#{id}")
    end

    def business_update(id, params = {})
      post_request("business/#{id}", params)
    end

    def business_delete(id)
      delete_request("business/#{id}")
    end

    def business_partner_urls(id)
      get_request("business/#{id}/partner_urls")
    end

    def business_integration_data(id)
      get_request("business/#{id}/integration_status")
    end

    def business_subscription(id)
      get_request("business/#{id}/subscription")
    end

    def business_get_additional_data(id)
      get_request("business/#{id}/additional_data")
    end

    def business_set_additional_data(id, params = {})
      post_request("business/#{id}/additional_data", params)
    end

    def business_get_google_attributes(id, params = {})
      get_request("business/#{id}/attributes", params)
    end

    def business_set_google_attributes(id, params = {})
      post_request("business/#{id}/attributes", params)
    end

    ##################
    # Business Fields
    ##################

    def business_fields_for_business(id)
      get_request("business/#{id}/business_fields")
    end
    alias business_get_business_fields business_fields_for_business

    def business_fields_for_organization(id)
      get_request("business/#{id}/business_fields")
    end
    alias organization_get_business_fields business_fields_for_organization

    def business_fields_for_provider(id)
      get_request("business/#{id}/business_fields")
    end
    alias provider_get_business_fields business_fields_for_provider

    ##################
    # Users
    ##################

    def user_me
      get_request("user/me")
    end

    def user_create(params = {})
      post_request("user", params)
    end

    def user_get(id)
      get_request("user/#{id}")
    end

    def user_update(id, params = {})
      post_request("user/#{id}", params)
    end

    def user_delete(id, params = {})
      delete_request("user/#{id}", params)
    end

    def users_search(params = {})
      get_request("user/search", params)
    end

    def users_count(params = {})
      get_request("user/search/count", params)
    end

    def user_reinvite(id)
      post_request("user/#{id}/invite")
    end

    def user_get_businesses(id)
      get_request("user/#{id}/businesses")
    end

    ###############
    # Groups
    ###############

    def groups_get
      get_request("groups")
    end

    def group_create(params = {})
      post_request("groups", params)
    end

    def group_get(id)
      get_request("groups/#{id}")
    end

    def group_update(id, params = {})
      put_request("groups/#{id}", params)
    end

    def group_delete(id)
      delete_request("groups/#{id}")
    end

    def group_get_businesses(id)
      get_request("groups/#{id}/businesses")
    end

    def group_manage_businesses(id, params = {})
      put_request("groups/#{id}/businesses", params)
    end

    #################
    # Subscriptions
    #################

    def subscribe_a_business(id)
      post_request("business/#{id}/subscribe")
    end
    alias business_subscribe subscribe_a_business

    def unsubscribe_a_business(id)
      post_request("business/#{id}/unsubscribe")
    end
    alias business_unsubscribe unsubscribe_a_business

    ##################
    # Reviews
    ##################

    def reviews_search(params = {})
      get_request("reviews", params)
    end

    def review_post_a_reply(params = {})
      post_request("comments", params)
    end

    def review_modify_a_reply(id, params = {})
      put_request("comments/#{id}", params)
    end

    def review_delete_a_reply(id)
      delete_request("comments/#{id}")
    end

    ##################
    # Reply templates
    ##################

    def reply_templates_search(params = {})
      get_request("reviews/templates/search", params)
    end

    def reply_template_create(params = {})
      post_request("reviews/template", params)
    end

    def reply_template_delete(id)
      delete_request("reviews/template/#{id}")
    end

    def reply_templates_placeholders
      get_request("reviews/templates/placeholders")
    end

    ####################
    # Reviews Analytics
    ####################

    def reviews_statistics(params = {})
      get_request("reviews/stats", params)
    end

    def reviews_qualitative_evolution(params = {})
      get_request("reviews/qualitative-evolution", params)
    end

    def reviews_quantitative_evolution(params = {})
      get_request("reviews/quantitative-evolution", params)
    end

    ####################
    # Categories
    ####################

    def category_get(id, params = {})
      get_request("category/#{id}", params)
    end

    def category_get(params = {})
      get_request("categories", params)
    end

    #####################
    # Address ??
    #####################

    #####################
    # Boosts
    #####################

    def boost_send_invitation(params = {})
      post_request("review_booster/send_invitation", params)
    end

    def boost_invitation_status(params = {})
      get_request("review_booster/invitation_status", params)
    end

    def boost_invitation_search(params = {})
      get_request("review_booster/search-invitation", params)
    end

    #####################
    # Presence
    #####################

    def presence_business_info(params = {})
      get_request("publisher_states/business_info", params)
    end

    def presence_businesses_info(params = {})
      get_request("publisher_states/businesses_info", params)
    end

    #####################
    # Presence analytics
    #####################

    def presence_analytics_get(params = {})
      get_request("presence_analytics", params)
    end

    def presence_analytics_export(params = {})
      get_request("presence_analytics_export", params)
    end

    #####################
    # Google post
    #####################

    def google_posts_search(params = {})
      get_request("google_posts", params)
    end

    def google_post_create(params = {})
      post_request("google_posts", params)
    end

    def google_post_get(id)
      get_request("google_posts/#{id}")
    end

    def google_post_update(id, params = {})
      put_request("google_posts/#{id}", params)
    end

    def google_post_delete(id)
      delete_request("google_posts/#{id}")
    end

    #####################
    # Custom Fields
    #####################

    def custom_field_create(params = {})
      post_request("custom_fields", params)
    end

    def custom_field_update(id, params = {})
      put_request("custom_fields/#{id}", params)
    end

    def custom_field_delete(id)
      delete_request("custom_fields/#{id}")
    end

    def custom_fields_order(params = {})
      post_request("custom_fields/order", params)
    end

    #####################
    # GMB Attributes
    #####################

    def gmb_attributes_list(params = {})
      get_request("attributes/list", params)
    end

  end
end
