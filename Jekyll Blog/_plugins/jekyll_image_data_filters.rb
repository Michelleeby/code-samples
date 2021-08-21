##
# Authors: Michelle Byrnes
# Name: jekyll_image_data_filters
# Summary: Jekyll filters to output image data.
##
# Descriptions:
#   image_size: img_path dimension_to_fetch -> dimension
require 'nokogiri'

module Jekyll
  module ImageDataFilters
    ICON_SVG_SCALE_FACTOR = 96
    
    def image_size(img, dimension)
      doc = File.open(img) { |f| Nokogiri::XML(f) }
      case dimension
      when "w"
        doc.at_css("svg")["width"].to_f * ICON_SVG_SCALE_FACTOR
      when "h"
        doc.at_css("svg")["height"].to_f * ICON_SVG_SCALE_FACTOR
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::ImageDataFilters)
