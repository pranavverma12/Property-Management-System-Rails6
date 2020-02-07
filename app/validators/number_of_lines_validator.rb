# frozen_string_literal: true

# Validates minimum and maximum number of lines
class NumberOfLinesValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value.is_a? String

    number_of_lines = value.count("\n") + 1

    # if supplied a `{ maximum: 12345 }` param
    if options[:maximum].present? && number_of_lines > options[:maximum]
      record.errors[attribute] << (
        options[:message] || I18n.t(:too_many_lines, scope: 'errors.messages',
                                                     count: options[:maximum])
      )
    end

    nil
  end
end
