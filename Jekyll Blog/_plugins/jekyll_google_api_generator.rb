##
# Authors: Michelle Byrnes
# Name: jekyll_google_api_generator
# Summary: A Jekyll generator that produces CSV files from Google Sheets API.
##
# Description: Data is first defined in site config. Then it is fed into a 
# DataDictionary where it is manipulated for use with google-apis-sheets-v4. An 
# API service is created with this data, and then a CSV file is written for 
# each fetched sheet from the specified spreadsheet.
require "google/apis/sheets_v4"
require "csv"
module GoogleSheetsApiImport
  class DataFilesGenerator < Jekyll::Generator
    priority :high

    def generate(site)
      dictionary = DataDictionary.new(site)

      service = Google::Apis::SheetsV4::SheetsService.new
      service.key = dictionary.key
      response = fetch_values(service, dictionary)

      response.value_ranges.each.with_index do |range, index|
        write_csv(range, dictionary, index)
      end
    end

    def fetch_values(service, dictionary)
      id = dictionary.id
      ranges = dictionary.ranges

      service.batch_get_spreadsheet_values(id, ranges: ranges)
    end

    def write_csv(range, dictionary, index)
      path = dictionary.output
      title = dictionary.titles[index]

      CSV.open("#{path}/#{title}.csv", "w") do |csv|
        range.values.each do |row|
          csv << row
        end
      end
    end
  end

  class DataDictionary 
    attr_accessor :key, :id, :sheets, :output, :ranges, :titles
    
    def initialize(site)
      @data = site.config["#{File.basename(__FILE__, ".rb")}"]
      @key = @data["api_key"]
      @id = @data["spreadsheet_id"]
      @sheets = @data["sheets_to_fetch"]
      @titles = @sheets.map{|sheet| sheet["title"]}
      @ranges = print_ranges(@titles, @sheets.map{|sheet| sheet["range"]})
      @output = @data["output_dir"]
    end

    def print_ranges(titles, ranges)
      titles.map.with_index{|title, i| "#{title}!#{ranges[i]}"}
    end
  end
end
