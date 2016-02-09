class Question < Sequel::Model
  plugin :pg_array_associations
  plugin :validation_helpers

  many_to_pg_array :questionaire_templates

  one_to_many :responses

  def validate
    super
    validates_presence [ :prompt, :type ]
  end
end
