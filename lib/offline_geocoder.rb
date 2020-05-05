require "offline_geocoder/version"
require "csv"
require "geokdtree"

class OfflineGeocoder
  CSV_PATH = File.expand_path('../og_cities1000.csv', __dir__)

  def initialize
    unless defined? @@cities
      @@cities = []
      @@tree = Geokdtree::Tree.new(2)
      @@table = []
      index = 0
      CSV.foreach(CSV_PATH, headers: true, header_converters: :symbol) do |row|
        as_hash = row.to_h
        as_hash[:lat] = as_hash[:lat].to_f
        as_hash[:lon] = as_hash[:lon].to_f
        @@tree.insert([row[:lat], row[:lon]], index)
        @@table << as_hash
        index += 1
      end

      return nil
    end
  end

  def search(query, lon = nil)
    lat, lon = lon.nil? ? [query[:lat], query[:lon]] : [query, lon]

    if lat && lon
      search_by_latlon(lat.to_f, lon.to_f)
    else
      search_by_attr(query)
    end
  end

  # Hide internal variables
  def inspect
    "#<#{self.class}:0x#{'%014x' % (self.object_id << 1)}>"
  end

  private

  def search_by_latlon(lat, lon)
    @@table[@@tree.nearest([lat, lon]).data.to_i].to_h
  end

  def search_by_attr(query = {})
    @@table.select { |object| object >= query }.first
  end
end
