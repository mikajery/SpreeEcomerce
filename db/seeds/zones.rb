south_east_asia    = Spree::Zone.create!(name: "South East Asia", description: "South east asia")

["Brunei Darussalam", "Cambodia", "Indonesia", "Lao People's Democratic Republic",
  "Malaysia", "Myanmar", "Philippines", "Singapore", "Thailand", "Viet Nam"].each do |name|
  south_east_asia.zone_members.create!(zoneable: Spree::Country.find_by!(name: name))
end


east_malaysia    = Spree::Zone.create!(name: "East Malaysia", description: "East")
west_malaysia    = Spree::Zone.create!(name: "West Malaysia", description: "West")


["Malaysia"].each do |name|
  east_malaysia.zone_members.create!(zoneable: Spree::Country.find_by!(name: name))
end

["Malaysia"].each do |name|
  west_malaysia.zone_members.create!(zoneable: Spree::Country.find_by!(name: name))
end


zone = Spree::Zone.where(:name => "East Malaysia").first
  if !zone.nil?
  zone.members.each do |member|
    member.delete
  end
end

