# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def full_name
    first_name.capitalize + ' ' + last_name.capitalize
  end
end
