Sequel.migration do
  change do

    create_table :questionnaires do
      primary_key :id

      FalseClass :completed, default: false

      foreign_key :user_id, :users, index: true, null: false
      foreign_key :questionnaire_template_id, :questionnaire_templates, index: true, null: false

      DateTime :created_at
      DateTime :updated_at
    end

  end
end
