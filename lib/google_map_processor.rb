class GoogleMapProcessor
  def self.build_map_data(locations)
    Gmaps4rails.build_markers(locations) do |location, marker|
      marker.lat location.latitude
      marker.lng location.longitude
    end
  end
end
