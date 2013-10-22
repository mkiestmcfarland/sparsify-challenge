# encoding: utf-8

module Sparsify
  # Your implementation goes here
  def self.sparse(source)
    flatten_level(source,'')
  end

  def self.unsparse(source)
    n = {}
    source.each do |key, value|
      if key.include?('.')
        unflatten_key(key, value, n)
      else
        n[key] = value
      end
    end
    return n
  end

  private
  def self.flatten_level(source, parent)
    flattened_hash = {}
    if source.length > 0
      source.each do |key, value|
        if value.is_a?(Hash)
          flattened_hash.merge!(flatten_level(value, parent+key+'.'))
        else
          flattened_hash[parent+key] = value
        end
      end
    else
      flattened_hash[parent.slice(0, parent.length-1)] = source
    end
    return flattened_hash
  end

  def self.unflatten_key(key, value, n)
    current_level = n
    split = key.split('.')
    split.each_with_index do |level, i|
      if i == split.length - 1
        current_level[level] = value
      else
        if !current_level.has_key?(level)
          current_level[level]  = {}
        end
        current_level = current_level[level]
      end
    end
  end
end
