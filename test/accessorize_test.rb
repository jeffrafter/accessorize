require 'test_helper'

# Not really sure when to do this :)
Thing.accessorize
Struct.new("User", :id)

class ApplicationController < ActionController::Base
  def current_user
    Struct::User.new(87)
  end
  
  def current_meta
    "Spilled milk"
  end  
end

class AccessorizeTest < ActiveSupport::TestCase
  should "create an accessor record when creating a thing" do
    assert_difference 'Accessorize::Accessor.count', 1 do
      Thing.create
    end
  end

  should "create an accessor record when updating a thing" do
    thing = Thing.create
    assert_difference 'Accessorize::Accessor.count', 1 do
      thing.update_attributes(:mood => 'Hasslehoffish')
    end
  end
  
  should "create an accessor record when destroying a thing" do
    thing = Thing.create
    assert_difference 'Accessorize::Accessor.count', 1 do
      thing.destroy
    end
  end
  
  should "create an accessor record when viewing a thing" do
    thing = Thing.create
    assert_difference 'Accessorize::Accessor.count', 1 do
      mood = Thing.last.mood
    end
  end

  should "set the accessor to the current user" do
    Accessorize::Extension.accessor = 42
    thing = Thing.create
    assert_equal 42, Accessorize::Accessor.last.accessor_id
  end

  should "set the meta to the current meta" do
    Accessorize::Extension.meta = "We were in the middle of tea"
    thing = Thing.create
    assert_equal "We were in the middle of tea", Accessorize::Accessor.last.meta
  end  
end

class ThingsControllerTest < ActionController::TestCase
  test "should set the accessor to the current user" do
    get :show, :id => things(:one).to_param
    assert_response :success
    assert_equal 87, Accessorize::Accessor.last.accessor_id
  end

  test "should set the meta to the current meta" do
    get :show, :id => things(:one).to_param
    assert_response :success
    assert_equal "Spilled milk", Accessorize::Accessor.last.meta
  end
end