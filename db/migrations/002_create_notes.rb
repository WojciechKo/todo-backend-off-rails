Sequel.migration do
  change do
    create_table(:notes) do
      Uuid :id,
           default: Sequel.function(:uuid_generate_v4),
           primary_key: true

      String :text,
             null: false
    end
  end
end
