require 'minitest/autorun'
load '../dinosaur_collection.rb'

class TestDinosaur < Minitest::Test
  def setup
    @dino = Dinosaur.new("test")
    @dino.walking = "mooo"
  end

  def test_that_walking_is_accessible
    assert_equal 'mooo', @dino.walking
  end

  def test_that_can_handle_missing_weight
    assert_equal nil, @dino.weight_in_tons
  end

  def test_that_can_handle_lbs_to_ton_conversion
    @dino.weight = 2000
    assert_equal 1, @dino.weight_in_tons
  end

  def test_facts
    assert_equal 7, @dino.facts_hash.length
    assert_equal "test", @dino.facts_hash[:name]
    assert_equal "mooo", @dino.facts_hash[:walking]
  end
end

class TestDinosaurCollection < Minitest::Test
  def setup
    @dinos = DinosaurCollection.new
  end

  def test_that_dinasourscollection_grabs_all_11_bipeds
    assert_equal 11, @dinos.select_by_walk_type('Biped').filter.length
  end

  def test_that_grabs_all_11_carnivores_period
    assert_equal 11, @dinos.select_carnivores.filter.length
  end

  def test_that_grabs_all_5_jurasic_period
    assert_equal 5, @dinos.get_by_period('Jurassic').filter.length
  end

  def test_that_grabs_all_1_albian_period
    assert_equal 1, @dinos.get_by_period('Albian').filter.length
  end

  def test_that_grabs_all_9_cretaceous_period
    assert_equal 9, @dinos.get_by_period('Cretaceous').filter.length
  end

  def test_that_grabs_all_big
    assert_equal 6, @dinos.select_big.filter.length
  end

  def test_that_grabs_all_small
    assert_equal 7, @dinos.select_small.filter.length
  end

  def test_that_grabs_all_small_biped
    puts @dinos.select_small.select_by_walk_type('Biped').print_filter
    actual = @dinos.select_small.select_by_walk_type('Biped').filter.length
    assert_equal 5, actual
  end

  def test_that_can_print_facts_about_carcharodontosaurus
    expected_output = "results:\nname: Carcharodontosaurus\nperiod: Albian\n"\
        "diet: Carnivore\nweight: 3000\nwalking: Biped\n"\
        "________________________________________\n"
    actual = @dinos.get_by_name('Carcharodontosaurus').print_filter
    assert_equal expected_output, actual
  end
end
