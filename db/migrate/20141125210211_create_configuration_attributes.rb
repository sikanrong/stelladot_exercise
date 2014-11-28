class CreateConfigurationAttributes < ActiveRecord::Migration
  def change
    create_table :configuration_attributes do |t|
      t.string :name
      t.index :name
      t.string :attribute_class, :limit => 50
      t.string :attribute_value_str
      t.timestamps
    end
  end
end
