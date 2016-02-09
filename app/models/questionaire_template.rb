class QuestionaireTemplate < Sequel::Model
  plugin :pg_array_associations
  plugin :validation_helpers

  pg_array_to_many :questions

  one_to_many :questionaires
  one_to_many :responses

  def validate
    super
    validates_presence [ :name ]
  end
end
