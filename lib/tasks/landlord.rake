namespace :landlord do

  desc "This will create a new record in the Landlord table by fetching details from Property table"
  task :enter_data => :environment do
    @errors = ActiveModel::Errors.new(self)

    Property.all.each do |property|
      if property.landlords.nil?
        landlord = Landlord.new(first_name: property.landlord_first_name, last_name: property.landlord_last_name, email: property.landlord_email)
        unless landlord.save
          p landlord.errors.messages
        end
      end  
    end
  end
end