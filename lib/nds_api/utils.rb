module NdsApi
  module Utils
    class << self
      def hash_keys_str_to_sym(hash)
        return hash unless hash.is_a? Hash
        hash.each_with_object({}) { |(k, v), memo| memo[k.to_sym] = v; }
      end
    end
  end
end
