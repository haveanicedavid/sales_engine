require 'csv'
require_relative 'merchant_repository'
require_relative 'customer_repository'
require_relative 'item_repository'
require_relative 'transaction_repository'
require_relative 'invoice_item_repository'
require_relative 'invoice_repository'
require_relative 'parser'

class SalesEngine
  #initialize parser that pushes merchant instances to the repo

  attr_reader :merchant_repository,
              :customer_repository,
              :item_repository,
              :transaction_repository,
              :invoice_repository,
              :invoice_item_repository

  include Parser

  def initialize(filepath)
    @filepath = filepath
  end

  def startup
    create_merchant_repository
    create_customer_repository
    create_item_repository
    create_invoice_repository
    create_transaction_repository
    create_invoice_item_repository
  end

  def create_merchant_repository
    merchant_data             = parse("#{@filepath}/merchants.csv")
    @merchant_repository      = MerchantRepository.new(merchant_data, self)
  end

  def create_customer_repository
    customer_data             = parse("#{@filepath}/customers.csv")
    @customer_repository      = CustomerRepository.new(customer_data, self)
  end

  def create_item_repository
    item_data                 = parse("#{@filepath}/items.csv")
    @item_repository          = ItemRepository.new(item_data, self)
  end

  def create_transaction_repository
    transaction_data          = parse("#{@filepath}/transactions.csv")
    @transaction_repository   = TransactionRepository.new(transaction_data, self)
  end

  def create_invoice_item_repository
    invoice_item_data         = parse("#{@filepath}/invoice_items.csv")
    @invoice_item_repository  = InvoiceItemRepository.new(invoice_item_data, self)
  end

  def create_invoice_repository
    invoice_data              = parse("#{@filepath}/invoices.csv")
    @invoice_repository       = InvoiceRepository.new(invoice_data, self)
  end

  def find_items_by_merchant_id(id)
    item_repository.find_all_by_merchant_id(id)
  end

  def find_invoices_by_merchant_id(id)
     invoice_repository.find_all_by_merchant_id(id)
  end

  def find_transactions_by_invoice_id(id)
    transaction_repository.find_all_by_invoice_id(id)
  end

  def find_invoice_items_by_invoice_id(id)
    invoice_item_repository.find_all_by_invoice_id(id)
  end

  def find_customer_by_customer_id(id)
    customer_repository.find_by_id(id)
  end

  def find_merchant_by_merchant_id(id)
    merchant_repository.find_by_id(id)
  end

  def find_invoice_by_invoice_id(invoice_id)
    invoice_repository.find_by_id(invoice_id)
  end

  def find_item_by_item_id(item_id)
    item_repository.find_by_id(item_id)
  end

  def find_invoice_items_by_item_id(id)
    invoice_item_repository.find_all_by_item_id(id)
  end

  def find_merchant_by_merchant_id_for_item(merchant_id)
    merchant_repository.find_by_id(merchant_id)
  end

  def find_invoice_by_id(invoice_id)
    invoice_repository.find_by_id(invoice_id)
  end

  def find_invoices_by_customer_id(id)
    invoice_repository.find_all_by_customer_id(id)
  end

  def create_invoice_item(inputs, id)
    invoice_item_repository.create_invoice_item(inputs, id)
  end

  def create_new_charge(charge_information, id)
    transaction_repository.create_new_charge(charge_information, id)
  end

end
