Sequel.migration do
  change do

    create_table :responses do
      primary_key :id

      column :responses, 'text[]'

      foreign_key :user_id, :users, index: true, null: false
      foreign_key :questionnaire_id, :questionnaires, index: true, null: false
      foreign_key :question_id, :questions, index: true, null: false

      DateTime :created_at
      DateTime :updated_at
    end

  end
end
