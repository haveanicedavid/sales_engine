require_relative 'test_helper'
require_relative '../lib/item_repository'
require 'bigdecimal'

class ItemRepositoryTest < Minitest::Test
  include Parser

  def setup 
    @fixtures = parse("./test/fixtures/items.csv") 
  end

  def test_it_exists
    assert ItemRepository.new(@fixtures, nil)
  end

  def test_it_knows_its_parent
    engine    = SalesEngine.new("stub")
    item_repo = ItemRepository.new(@fixtures, engine)

    assert_equal engine, item_repo.engine
  end

  def test_it_returns_all_item
    item_repo = ItemRepository.new(@fixtures, nil)

    refute item_repo.all.empty?
  end

  def test_it_returns_random_items
    item_repo = ItemRepository.new(@fixtures, nil)

    assert item_repo.random
  end

  def test_it_can_find_by_id
    item_repo = ItemRepository.new(@fixtures, nil)
    result    = item_repo.find_by_id(1)

    assert_equal 1, result.id
  end

  def test_it_can_find_all_by_id
    item_repo = ItemRepository.new(@fixtures, nil)
    result    = item_repo.find_all_by_id(4)

    assert_equal 1, result.count
  end

  def test_it_can_find_by_name
    item_repo = ItemRepository.new(@fixtures, nil)
    result    = item_repo.find_by_name("Item Autem Minima")
    assert_equal 2, result.id
  end

  def test_it_can_find_all_by_name
    item_repo = ItemRepository.new(@fixtures, nil)
    result    = item_repo.find_all_by_name("Item Autem Minima")

    assert_equal 1, result.count
  end

  def test_it_can_find_by_desription
    
    item_repo = ItemRepository.new(@fixtures, nil)
    result    = item_repo.find_by_description("Sunt eum id eius magni consequuntur delectus veritatis. Quisquam laborum illo ut ab. Ducimus in est id voluptas autem.")

    assert_equal 4, result.id
  end

  def test_it_can_find_all_by_description
    
    item_repo = ItemRepository.new(@fixtures, nil)
    result    = item_repo.find_all_by_description("Sunt eum id eius magni consequuntur delectus veritatis. Quisquam laborum illo ut ab. Ducimus in est id voluptas autem.")

    assert_equal 1, result.count
  end

  def test_it_can_find_by_unit_price
    
    item_repo = ItemRepository.new(@fixtures, nil)
    result    = item_repo.find_by_unit_price(BigDecimal.new(67076)/100)

    assert_equal 2, result.id
  end

  def test_it_can_find_all_by_unit_price
    
    item_repo = ItemRepository.new(@fixtures, nil)
    result    = item_repo.find_all_by_unit_price(BigDecimal.new(4291)/100)

    assert_equal 1, result.count
  end

  def test_it_can_find_by_merchant_id
     
    item_repo = ItemRepository.new(@fixtures, nil)
    result    = item_repo.find_by_merchant_id(1)

    assert_equal 1, result.id
  end

  def test_it_can_find_all_by_merchant_id
    item_repo = ItemRepository.new(@fixtures, nil)
    result    = item_repo.find_all_by_merchant_id(1)

    assert_equal 10, result.count
  end

  def test_it_can_find_by_created_at
    item_repo = ItemRepository.new(@fixtures, nil)
    result    = item_repo.find_by_created_at "2012-03-27 14:53:59 UTC"

    assert_equal 1, result.id
  end

  def test_it_can_find_all_by_created_at
    item_repo = ItemRepository.new(@fixtures, nil)
    result    = item_repo.find_all_by_created_at "2012-03-27 14:53:59 UTC"

    assert_equal 10, result.count
  end

  def test_it_can_find_by_updated_at
    item_repo = ItemRepository.new(@fixtures, nil)
    result    = item_repo.find_by_updated_at "2012-03-27 14:53:59 UTC"

    assert_equal 1, result.id
  end

  def test_it_can_find_all_by_updated_at
    item_repo = ItemRepository.new(@fixtures, nil)
    result    = item_repo.find_all_by_updated_at "2012-03-27 14:53:59 UTC"

    assert_equal 10, result.count
  end

  def test_it_can_find_invoice_items
    engine       = FakeEngine.new
    item_repo    = ItemRepository.new(@fixtures, engine)
    invoice_item = item_repo.find_invoice_items(3)

    assert_equal "invoice item 3", invoice_item
  end

  def test_it_can_find_merchant_by_merchant_id
    engine       = FakeEngine.new
    item_repo    = ItemRepository.new(@fixtures, engine)
    merchant     = item_repo.find_merchant(1)

    assert "merchant id 1"
  end 
end

class FakeEngine
  def find_invoice_items_by_item_id(id)
    "invoice item #{id}"
  end

  def find_merchant_by_merchant_id_for_item(merchant_id)
    "merchant id #{merchant_id}"
  end
end