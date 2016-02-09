Sequel.migration do
  change do

    create_table :responses do
      primary_key :id

      String :response

      foreign_key :user_id, :users, index: true, null: false
      foreign_key :questionaire_id, :questionaires, index: true, null: false
      foreign_key :question_id, :questions, index: true, null: false

      DateTime :created_at
      DateTime :updated_at
    end

  end
end
