class Response < Sequel::Model
  plugin :validation_helpers

  many_to_one :user
  many_to_one :questionnaire
  many_to_one :question

  def validate
    super
  end
end
