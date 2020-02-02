# frozen_string_literal: true

# Validates minimum and maximum number of lines
class NoSpacesValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value.is_a? String

    number_of_spaces = value.strip.count(' ')

    if number_of_spaces.positive?
      record.errors[attribute] << (
        options[:message] || I18n.t(:no_spaces, scope: 'errors.messages')
      )
    end

    nil
  end
end
