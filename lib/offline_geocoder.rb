require "offline_geocoder/version"
require "csv"
require "geokdtree"

class OfflineGeocoder
  def initialize
    unless defined? @@cities
      @@cities = []
      @@tree = Geokdtree::Tree.new(2)
      index = 0
      csv_path = File.expand_path("../../og_cities1000.csv", __FILE__)
      lines = File.read(csv_path).split("\n")
      @@fields = lines[0].split(',').collect(&:to_sym)
      lines[1..-1].each {|line|
        parsed_line =
          if line.include?('"')
            CSV.parse(line)[0]
          else
            line.split(',')
          end
        parsed_line[0] = parsed_line[0].to_f
        parsed_line[1] = parsed_line[1].to_f

        line_as_h = {}
        parsed_line.each_with_index do |value, col|
          line_as_h[@@fields[col]] = value
        end

        @@cities << line_as_h
        @@tree.insert([line_as_h[:lat], line_as_h[:lon]], index)
        index += 1
      }

      return nil
    end
  end

  def search(query, lon = nil)
    if query.is_a? Hash
      search_by_attr(query)
    elsif lon
      lat = query.to_f
      lon = lon.to_f
      @@cities[@@tree.nearest([lat, lon]).data.to_i]
    end
  end

  # Hide internal variables
  def inspect
    "#<#{self.class}:0x#{'%014x' % (self.object_id << 1)}>"
  end

  private

  def search_by_attr(query = {})
    @@cities.select { |object|  object >= query }.first
  end
end
