# encoding: utf-8

module Sparsify
  # Your implementation goes here
  def self.sparse(source, options={:separator=>'.'})
    flatten_level(source, options[:separator], '')
  end

  def self.unsparse(source, options={:separator=>'.'})
    n = {}
    source.each do |key, value|
      if key.include?(options[:separator])
        unflatten_key(key, value, options[:separator], n)
      else
        n[key] = value
      end
    end
    return n
  end

  private
  def self.flatten_level(source, separator, parent)
    flattened_hash = {}
    if source.length > 0
      source.each do |key, value|
        if value.is_a?(Hash)
          flattened_hash.merge!(flatten_level(value, separator, parent+key+separator))
        else
          flattened_hash[parent+key] = value
        end
      end
    else
      flattened_hash[parent.slice(0, parent.length-1)] = source
    end
    return flattened_hash
  end

  def self.unflatten_key(key, value, separator, n)
    current_level = n
    split = key.split(separator)
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
