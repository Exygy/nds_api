module NdsApi
  class Url
    def initialize(options = { dev: false })
      @options = options
      @prod = !@options[:dev]
    end

    ##### Agency #####

    def get_agency_option(type_id = nil)
      raise 'NDS API ERROR: Agency Key required' unless @options[:agency_key]
      "#{base_url}/agencies/config/options?agencyKey=#{@options[:agency_key]}#{type_id ? "&typeId=#{type_id}" : ''}"
    end

    ##### CLIENTS #####

    def clients
      "#{base_url}/clients"
    end

    def client_by_email(email)
      "#{client_search}/findByEmail?email=#{email}"
    end

    def client_by_phone(phone)
      "#{client_search}/findByPhone?phone=#{phone}"
    end

    def client_by_first_name_and_last_name(first_name, last_name)
      "#{client_search}/findByName?lastName=#{last_name}&firstName=#{first_name}"
    end

    def client_by_id(id)
      "#{clients}/#{id}"
    end

    ##### CHILDREN #####

    def children
      "#{base_url}/children"
    end

    def child_by_uid(uid)
      "#{children}/#{uid}"
    end

    def children_by_client_id(client_id)
      "#{base_url}/clients/#{client_id}/children"
    end

    ##### COMMUNITIES #####

    def communities
      "#{base_url}/communities?sort=lastModifiedTime,DESC"
    end

    ##### PERSON #####

    def persons
      "#{base_url}/persons"
    end

    def person_by_id(id)
      "#{persons}/#{id}"
    end

    #### POSITIONS #####

    def positions_by_work_email(email)
      "#{base_url}/positions/search/findByWorkEmail?workEmail=#{email}"
    end

    ##### PROVIDERS #####

    def search_providers(params = nil)
      params = URI.encode_www_form(params) if params
      "#{providers}/search/findByCriteriaObject#{params ? "?#{params}" : ''}"
    end

    def search_providers_elastic
      "#{providers}/search"
    end

    def providers
      "#{base_url}/providers"
    end

    def provider_by_uid(uid)
      "#{base_url}/providers/#{uid}"
    end

    def provider_by_id(id)
      "#{base_url}/providers/search/findByProviderId?providerId=#{id}"
    end

    def providers_by_center_name(center_name)
      "#{provider_search}/findByCenterName?centerName=#{center_name}"
    end

    def providers_by_email(email)
      "#{provider_search}/findByEmail?email=#{email}"
    end

    def provider_schedule(uid)
      "#{providers}/#{uid}/schedule"
    end

    def provider_rates(uid)
      "#{providers}/#{uid}/rates"
    end

    def provider_enrollments(uid)
      "#{providers}/#{uid}/enrollments"
    end

    def search_providers_bulk
      "#{providers}/bulk"
    end

    ##### REFERRALS #####

    def referrals
      "#{base_url}/referrals"
    end

    def referral_by_id(id)
      "#{referrals}/#{id}"
    end

    def referral_by_client_id(id)
      "#{clients}/#{id}/referrals"
    end

    def referrals_before_date(date)
      "#{referral_search}/findByDateBefore?date=#{date}"
    end

    def referrals_after_date(date)
      "#{referral_search}/findByDateAfter?date=#{date}"
    end

    def referrals_in_date_range(start_date, end_date)
      "#{referral_search}/findByDateBetween?startDate=#{start_date}&endDate=#{end_date}"
    end

    private

    # cover: "create_XXXXXX", "update_XXXXXX"
    def method_missing(method_sym, *arguments, &block)
      create_prefix = 'create_'
      update_prefix = 'update_'

      prefix = create_prefix if method_sym[0..create_prefix.length - 1] == create_prefix
      prefix = update_prefix if method_sym[0..update_prefix.length - 1] == update_prefix

      if method_sym[0..prefix.length - 1] == prefix
        entities = method_sym[prefix.length..method_sym.length]
        send(entities)
      else
        super
      end
    end

    def client_search
      "#{clients}/search"
    end

    def provider_search
      "#{providers}/search"
    end

    def referral_search
      "#{referrals}/search"
    end

    def base_url
      if @prod
        'https://api.naccrraware.net'
      else
        'https://api.staging.naccrraware.net'
      end
    end
  end
end
