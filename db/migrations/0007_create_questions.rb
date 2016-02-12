Sequel.migration do
  change do

    create_table :questions do
      primary_key :id

      String :prompt, null: false
      String :type, null: false

      column :choices, 'text[]'
      column :meta, 'jsonb'

      DateTime :created_at
      DateTime :updated_at
    end

  end
end
