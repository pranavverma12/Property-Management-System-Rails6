# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'sessions/new.html.erb', type: :view do
  it 'displays login form' do
    @session = OpenStruct.new(
      errors: {}.with_indifferent_access
    )

    render

    expect(rendered).to match have_css('form[action="/login"] input[name="username"]')
    expect(rendered).to match have_css('form[action="/login"] input[name="password"]')
    expect(rendered).to match have_css('form[action="/login"] button[type="submit"]')

    expect(rendered).to_not match(/error/) # no errors on page
  end

  it 'display username errors if present' do
    @session = OpenStruct.new(
      errors: { username: 'some kind of username error message' }.with_indifferent_access
    )

    render

    expect(rendered).to match(/some kind of username error message/)
  end

  it 'display password errors if present' do
    @session = OpenStruct.new(
      errors: { password: 'some kind of password error message' }.with_indifferent_access
    )

    render

    expect(rendered).to match(/some kind of password error message/)
  end
end
