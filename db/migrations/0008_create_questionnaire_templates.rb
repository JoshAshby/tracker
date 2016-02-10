Sequel.migration do
  change do

    create_table :questionnaire_templates do
      primary_key :id

      String :name, index: true, unique: true, null: false
      String :description

      column :question_ids, 'integer[]'

      DateTime :created_at
      DateTime :updated_at
    end

  end
end
