class ConfigurationAttribute < ActiveRecord::Base
  def self.set_config_value(name, value)
    config_obj = self.get_config_obj(name)

    if(config_obj.nil?)
      #create a new one then
      config_obj = ConfigurationAttribute.new({:name => name})
    end

    config_obj.set_value value
    config_obj.save!
    return config_obj
  end

  def self.get_config_value(name)
    existing_config = self.get_config_obj(name)

    if(existing_config.nil?)
      return nil
    else
      return existing_config.get_value
    end
  end

  def set_value(value)
    case (value)
      when String
        self.attribute_class = "String"
        self.attribute_value_str = value
      when TrueClass
        self.attribute_class = "TrueClass"
        self.attribute_value_str = "true"
      when FalseClass
        self.attribute_class = "FalseClass"
        self.attribute_value_str = "false"
      when Fixnum
        self.attribute_class = "Integer"
        self.attribute_value_str = value.to_s
      when Float
        self.attribute_class = "Float"
        self.attribute_value_str = value.to_s
      else
        raise "Trying to set an unsupported type to a ConfigurationAttribute (#{value.class.to_s})!"
    end
  end

  def get_value
    case(self.attribute_class)
      when "String"
        return self.attribute_value_str
      when "TrueClass"
        return true;
      when "FalseClass"
        return false;
      when "Float"
        return Float(self.attribute_value_str)
      when "Integer"
        return Integer(self.attribute_value_str)
      else
        raise "ConfigurationAttribute #{self.id} has no value attached!" #should never happen
    end
  end

  private
    def self.get_config_obj(name)
      return ConfigurationAttribute.find_by_name(name)
    end
end
