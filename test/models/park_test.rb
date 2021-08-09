require 'test_helper'

class ParkTest < ActiveSupport::TestCase
  test "should not save a park without a name" do
    park = Park.new
    assert_not park.save, "Park was saved without a title"
  end

  test "should not save a park without a region" do
    park = Park.new(name: 'testpark')
    assert_not park.save, "Park was saved without a region"
  end
end

