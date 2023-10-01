# rubocop:disable all
# frozen_string_literal: true

class Kredis::Types::Hash < Kredis::Types::Proxying
  proxying :hget, :hset, :hmget, :hdel, :hgetall, :hkeys, :hvals, :del, :exists?, :expire, :hincrby

  attr_accessor :typed, :expires_in

  def update(**entries)
    return unless entries.flatten.any?

    h = hset entries.transform_values{ |val| type_to_string(val, typed) }

    set_expire

    h
  end

  private

  attr_accessor :expire_at

  def set_expire
    return unless expires_in

    if expired?
      @expire_at = expires_in.from_now

      expire expires_in
    end
  end

  def expired?
    !expire_at || expire_at.past?
  end
end

class Kredis::Types::List < Kredis::Types::Proxying
  proxying :lrange, :lrem, :lpush, :ltrim, :rpush, :exists?, :del, :expire

  attr_accessor :typed, :expires_in

  def prepend(*elements)
    return unless elements.flatten.any?

    l = lpush types_to_strings(elements, typed)

    set_expire

    l
  end

  def append(*elements)
    return unless elements.flatten.any?

    r = rpush types_to_strings(elements, typed)

    set_expire

    r
  end
  alias << append

  private

  attr_accessor :expire_at

  def set_expire
    return unless expires_in

    if expired?
      @expire_at = expires_in.from_now

      expire expires_in
    end
  end

  def expired?
    !expire_at || expire_at.past?
  end
end

module Kredis::Types
  def list(key, typed: :string, config: :shared, after_change: nil, expires_in: nil)
    type_from(List, config, key, after_change: after_change, typed: typed, expires_in: expires_in)
  end

  def unique_list(key, typed: :string, limit: nil, config: :shared, after_change: nil, expires_in: nil)
    type_from(UniqueList, config, key, after_change: after_change, typed: typed, limit: limit, expires_in: expires_in)
  end

  def hash(key, typed: :string, config: :shared, after_change: nil, expires_in: nil)
    type_from(Hash, config, key, after_change: after_change, typed: typed, expires_in: expires_in)
  end
end
