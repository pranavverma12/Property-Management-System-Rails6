# frozen_string_literal: true

User.delete_all
Property.delete_all
Tenant.delete_all

User.create!(username: 'admin', password: 'securePassword')

(0..25).each do |i|
  user = User.new(
    username: "#{Faker::Internet.username(specifier: 5..10, separators: %w[])}#{i}",
    password: 'securePassword'
  )

  next if user.save

  puts 'Failed to build a seed User:'
  pp user.errors.full_messages
  pp user
  exit 0
end

(0..35).each do |_i|
  name = Faker::FunnyName.name

  tenant = Tenant.new(first_name: name.split(' ').first,
                      last_name: name.split(' ')[1..].join(' '),
                      email: Faker::Internet.safe_email(name: name))

  next if tenant.save

  puts 'Failed to build a seed Tenant:'
  pp tenant.errors.full_messages
  pp tenant
  exit 0
end

(0..40).each do |_i|
  name = Faker::FunnyName.name
  address = Faker::Address.full_address

  property = Property.new(property_name: address.split(',').first,
                          property_address: address.split(',').each(&:strip!).join("\n"),
                          landlord_first_name: name.split(' ').first,
                          landlord_last_name: name.split(' ')[1..].join(' '),
                          landlord_email: Faker::Internet.safe_email(name: name))

  next if property.save

  puts 'Failed to build a seed Property:'
  pp property.errors.full_messages
  pp property
  exit 0
end
