class Location < ActiveRecord::Base
  belongs_to :region
  geocoded_by :address, :latitude => :lat, :longitude => :lng   # can also be an IP address
  acts_as_gmappable :process_geocoding => false, :lat => "lat", :lng => "lng", :address => "address"

  after_validation :geocode    
  attr_accessible :region_id, :address, :twitter_handle, :admin_notes, :contact, :donor_type, :hours, :is_donor, :lat, :lng, :name, :public_notes, :recip_category, :website, :receipt_key

  def gmaps4rails_title
    self.name
  end
  def gmaps4rails_infowindow
    ret = "<span style=\"font-weight: bold;color: darkblue;\">#{self.name}</span><br>"
    ret += self.address.gsub("\n","<br>") unless self.address.nil?
    ret += "<br>"
    ret += self.contact.gsub("\n","<br>") unless self.contact.nil?
    ret += "<br>"
    ret += self.hours.gsub("\n","<br>") unless self.hours.nil?
    ret += "<br>"
    ret += "<a href=\"#{self.website}\">website</a>" unless self.website.nil?
    ret
  end

end
