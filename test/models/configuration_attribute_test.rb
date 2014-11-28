require 'test_helper'

class ConfigurationAttributeTest < ActiveSupport::TestCase
  test "Fetch float configuration value" do
    ret_val = ConfigurationAttribute.get_config_value("preferred_gravity_ratio");
    assert(ret_val.is_a? Float)
    assert(ret_val === 1.10232)
  end

  test "Fetch bool configuration value" do
    true_val = ConfigurationAttribute.get_config_value("activate_hyperspeed");
    false_val = ConfigurationAttribute.get_config_value("activate_planetary_nuke");
    assert(true_val === true)
    assert(false_val === false)
  end

  test "Fetch int configuration value" do
    ret_val = ConfigurationAttribute.get_config_value("total_number_bananas");
    assert(ret_val.is_a? Integer)
    assert(ret_val === 20)
  end

  test "Fetch string configuration value" do
    ret_val = ConfigurationAttribute.get_config_value("welcome_msg");
    assert(ret_val.is_a? String)
    assert(ret_val == "Hello World!")
  end

  test "Update string config value" do
    #set the new config value.
    ConfigurationAttribute.set_config_value("welcome_msg", "Goodbye cruel world!!");

    #some time later, it is fetched...
    ret_val = ConfigurationAttribute.get_config_value("welcome_msg");
    assert(ret_val.is_a? String)
    assert(ret_val == "Goodbye cruel world!!")
  end

  test "Update bool config value" do
    #set the new config value.
    ConfigurationAttribute.set_config_value("activate_planetary_nuke", true);

    #some time later, it is fetched...
    ret_val = ConfigurationAttribute.get_config_value("activate_planetary_nuke");
    assert(ret_val.is_a? TrueClass)
    assert(ret_val === true)
  end

  test "Update integer config value" do
    #set the new config value. (remove 1 banana)
    ConfigurationAttribute.set_config_value("total_number_bananas", 19);

    #some time later, it is fetched...
    ret_val = ConfigurationAttribute.get_config_value("total_number_bananas");
    assert(ret_val.is_a? Integer)
    assert(ret_val === 19)
  end

  test "Update float config value" do
    #set the new config value. (remove 1 banana)
    ConfigurationAttribute.set_config_value("preferred_gravity_ratio", 2.102);

    #some time later, it is fetched...
    ret_val = ConfigurationAttribute.get_config_value("preferred_gravity_ratio");
    assert(ret_val.is_a? Float)
    assert(ret_val === 2.102)
  end

  #this will test updating a config value with a value of different type.
  test "Update config value class" do
    #set the new config value to a float where there used to be an Int...
    resulting_conf_obj = ConfigurationAttribute.set_config_value("total_number_bananas", 20.5);
    resulting_conf_obj.reload

    #some time later, it is fetched (should now be a Float)...
    ret_val = ConfigurationAttribute.get_config_value("total_number_bananas");
    assert(ret_val.is_a? Float)
    assert(ret_val === 20.5)
    assert(resulting_conf_obj.attribute_class == "Float")
  end
end
