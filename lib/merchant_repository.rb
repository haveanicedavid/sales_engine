require_relative 'merchant'
require_relative 'parser'

class MerchantRepository

  attr_reader :merchants, :engine

  include Parser

  def initialize(data, engine)
    @engine    = engine
    @merchants = data.map { |line| Merchant.new(line, self) }
  end

  def inspect
    "#<{self.class} #{merchants.size} rows>"
  end

  def all
    merchants
  end

  def random
    merchants.sample
  end

  def find_by_id(id)
    merchants.find { |merchant| merchant.id == id }
  end

  def find_all_by_id(id)
    merchants.select { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    merchants.find { |merchant| merchant.name == name }
  end

  def find_all_by_name(name)
    merchants.select { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_by_created_at(created_at)
    merchants.find { |merchant| merchant.created_at == created_at }
  end

  def find_all_by_created_at(created_at)
    merchants.select { |merchant| merchant.created_at == created_at }
  end

  def find_by_updated_at(updated_at)
    merchants.find { |merchant| merchant.updated_at == updated_at }
  end

  def find_all_by_updated_at(updated_at)
    merchants.select { |merchant| merchant.updated_at == updated_at }
  end

  def find_items(id)
    engine.find_items_by_merchant_id(id)
  end

  def find_invoices(id)
    engine.find_invoices_by_merchant_id(id)
  end

  def most_revenue(x)
    sorted = merchants.sort_by {|merchant| merchant.revenue }.reverse!
    sorted.first(x)
  end

  def most_items(x)
    sorted = merchants.sort_by { |merchant| merchant.items_sold }.reverse!
    sorted.first(x)
  end

  def revenue(date)
    revenue_per_merchant = merchants.map { |merchant| merchant.revenue(date)}
    revenue_per_merchant.reduce(0) { |sum, x| sum + x }
  end


end
