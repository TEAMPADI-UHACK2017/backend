class DistanceChecker
  def initialize(lat, long)
    @lat = lat
    @long = long
  end

  def with_in_distance?(lat, long, distance, units: :km)
    computed_distance(lat, long, units: units) <= distance
  end

  def computed_distance(lat, long, units: :km)
    Geocoder::Calculations.distance_between([@lat, @long], [lat, long], units: units)
  end
end