module Nameable
  include FieldsValidator
  extend ActiveSupport::Concern

  included do
    load_required_attributes(*%w{firstname lastname})
    validate_required_attributes
  end

  public

  def full_name
    "#{firstname} #{lastname}"
  end

  def proper_name
    "#{lastname.upcase}, #{firstname}"
  end

  private

  def required_database_fields
    result=defined?(super) ? super : []
    result+=[:firstname, :lastname]
  end

end

