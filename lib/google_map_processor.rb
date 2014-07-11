class GoogleMapProcessor
  def self.build_map_data(routes)
    Gmaps4rails.build_markers(@route) do |route , marker|
      marker.lat route.latitude
      marker.lng route.longitude
      marker.infowindow route.lpp
    end
  end
end
