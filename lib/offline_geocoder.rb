require "offline_geocoder/version"
require "csv"
require "geokdtree"

class OfflineGeocoder
  def initialize
    unless defined? @@cities
      @@cities = []
      @@textual = {}
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
        @@cities << parsed_line
        @@textual[parsed_line[2..-1].join(' ').downcase] = parsed_line
        @@tree.insert([parsed_line[0], parsed_line[1]], index)
        index += 1
      }

      return nil
    end
  end

  def search(lat_or_name, lon = nil)
    lat = lat_or_name.to_f
    lon = lon.to_f if lon

    if lat && lon
      record = @@cities[@@tree.nearest([lat_or_name.to_f, lon.to_f]).data.to_i]
    else
      record = search_by_name(lat_or_name)
    end

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

  private

  ##
  # Gets the "first" item where the searched name can be found in the names.
  def search_by_name(name)
    @@textual.select { |k,v| k.include?(name.downcase) }.first[1]
  end
end
