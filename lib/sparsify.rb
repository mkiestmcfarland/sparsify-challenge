# encoding: utf-8

module Sparsify
  # Your implementation goes here
  def self.sparse(source)
    flatten_level(source,'')
  end

  private
  def self.flatten_level(source, parent)
    flattened_hash = {}
    source.each do |key, value|
      if value.is_a?(Hash)
        flattened_hash.merge!(flatten_level(value, parent+key+'.'))
      else
        flattened_hash[parent+key] = value
      end
    end
    return flattened_hash
  end
end
