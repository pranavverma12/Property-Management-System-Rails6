# frozen_string_literal: true

User.delete_all
Tenant.delete_all
Landlord.delete_all
Property.delete_all
PropertyLandlord.delete_all

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

  landlord = Landlord.new(first_name: name.split(' ').first,
                          last_name: name.split(' ')[1..].join(' '),
                          email: Faker::Internet.safe_email(name: name))

  if landlord.save
    address = Faker::Address.full_address

    property = Property.new(property_name: address.split(',').first,
                            property_address: address.split(',').each(&:strip!).join("\n"),
                            tenancy_security_deposit: 2000,
                            tenancy_monthly_rent: 2500
                            )

    if property.save
      property_landlord = property.property_landlords.new(landlord_id: landlord.id)

      next if property_landlord.save

      puts 'Failed to build a seed Property Landlord:'
      pp property_landlord.errors.full_messages
      pp property_landlord
      exit 0
    else
      puts 'Failed to build a seed Property:'
      pp property.errors.full_messages
      pp property
      exit 0
    end
  else
    puts 'Failed to build a seed Landlord:'
    pp landlord.errors.full_messages
    pp landlord
    exit 0
  end
end
