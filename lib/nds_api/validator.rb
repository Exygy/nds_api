module NdsApi
  module Validator
    class << self
      def validate_search_providers_params!(params)
        raise "NDS API ERROR: Invalid params: #{invalid_params(params).join(' - ')}" unless invalid_params(params).empty?
      end

      private

      def invalid_params(params)
        invalid_params = []
        if params
          params.keys.each do |param|
            invalid_params << param unless is_valid_field?(param)
          end
        end
        invalid_params
      end

      def is_valid_field?(field)
        valid_fields.include?(field.to_s)
      end

      def valid_fields
        %w[agesServiced
           ageGroups
           locationA
           locationB
           distance
           zips
           attributesLocal17
           typesOfCare
           shiftType
           acceptsChildren
           yearlySchedule
           weeklySchedule
           dailySchedule
           financialAssist
           languages
           attributesLocal3
           generalLocal1
           generalLocal2
           totalVacancies
           vacanciesByAge
           vacancyDateRange
           meals
           environment
           weeklyRate
           monthtlyRate
           beforeSchool
           afterSchool
           acceptsDropIns
           rotating
           openHolidays
           tempEmergency
           open24Hours]
      end
    end
  end
end
