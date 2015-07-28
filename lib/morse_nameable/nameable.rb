module Nameable
  include FieldsValidator
  extend ActiveSupport::Concern

  included do
    validate_column_names(*%w{firstname lastname})
    load_required_attributes(*%w{firstname lastname})
  end

  public

  def full_name
    "#{firstname} #{lastname}"
  end

  def proper_name
    "#{lastname.upcase}, #{firstname}"
  end

  private

end

