namespace :property_landlords do

  desc "This will assign the property to landlords by fetching details from Property table"
  task :enter_data => :environment do
    @errors = ActiveModel::Errors.new(self)

    Property.all.each do |property|
      if property.landlords.empty?
        landlord = Landlord.find_by(email: property.landlord_email)

        if landlord.present?
          property_landlord = PropertyLandlord.where(property_id: property.id, 
                                                     landlord_id: landlord.id
                                                    ).first_or_create
          
          p property_landlord.errors.messages unless property_landlord.errors.empty?
        end
      end  
    end
  end
end