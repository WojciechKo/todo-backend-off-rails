Sequel.migration do
  change do
    create_table(:notes) do
      primary_key :id
      column :text, "text", :null=>false
    end
    
    create_table(:schema_info) do
      column :version, "integer", :default=>0, :null=>false
    end
  end
end
