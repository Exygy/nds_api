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
        %w[
          acceptsChildren
          acceptsDropIns
          afterSchool
          ageGroups
          agesServiced
          attributesLocal17
          attributesLocal3
          beforeSchool
          dailySchedule
          distance
          environment
          financialAssist
          generalLocal1
          generalLocal2
          languages
          locationA
          locationB
          meals
          monthlyRate
          open24Hours
          openHolidays
          providerIds
          rotating
          shiftLocal1
          shiftType
          tempEmergency
          totalVacancies
          typesOfCare
          vacanciesByAge
          vacancyDateRange
          weeklyRate
          weeklySchedule
          yearlySchedule
          zips
        ]
      end
    end
  end
end
