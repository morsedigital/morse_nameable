module Nameable
  extend ActiveSupport::Concern
  include FieldsValidator

  included do
    validate_required_attributes
  end

  class_methods do
    def required_attributes
      result=defined?(super) ? super : []
      result+=required_nameable_attributes
    end

    def required_database_fields
      result=defined?(super) ? super : []
      result+=[:firstname, :lastname]
    end

    def required_nameable_attributes
      [:firstname,:lastname]
    end
  end

  public

  def first_name
    firstname
  end

  def first_name=(thing)
    self.firstname=thing
  end

  def full_name
    "#{firstname} #{lastname}"
  end

  def proper_name
    "#{lastname.upcase}, #{firstname}"
  end

  def surname
    lastname
  end

  def surname=(thing)
    self.lastname=thing
  end

  def title
    return super if defined?(super)
    full_name
  end

  private


end

