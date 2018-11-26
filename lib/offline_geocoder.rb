require "offline_geocoder/version"
require "csv"
require "geokdtree"

class OfflineGeocoder
  def initialize
    unless defined? @@cities
      @@cities = []
      @@points = []
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
        @@cities << parsed_line
        @@points << [parsed_line[0], parsed_line[1], index]
        index += 1
      }

      @@tree = Geokdtree::Tree.new(@@points)
      return nil
    end
  end

  def search(latitude, longitude)
    record = @@cities[@@tree.nearest(latitude.to_f, longitude.to_f)]
    hash_record = {}
    record.each_with_index do |value, index|
      hash_record[@@fields[index]] = value
    end
    hash_record
  end

  # Hide internal variables
  def inspect
    "#<#{self.class}:0x#{'%014x' % (self.object_id << 1)}>"
  end
end
