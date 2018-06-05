module NdsApi
  module Utils
    class << self

      def hash_keys_str_to_sym(hash)
        hash.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
      end

    end
  end
end
