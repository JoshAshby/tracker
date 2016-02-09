class Questionaire < Sequel::Model
  plugin :validation_helpers

  many_to_one :user
  many_to_one :questionaire_template

  one_to_many :responses

  def validate
    super
  end
end
