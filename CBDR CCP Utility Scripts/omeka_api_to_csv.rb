###
 # Pulls Omeka items from the API, writes each item's metadata values to a CSV file.
 # @author(s) Michelle Byrnes
 # @name omeka_api_to_csv
###
require "http"
require "csv"
require "json"


### CONTENTS ###
 # Methods 
 # Constants
 # Variables
 # Execution
###


### METHODS ###


### 
 # Parses HTTP, JSON response objects into Ruby objects.
 # @parameter {string} url -- The URL to make the HTTP get request with.
 # @parameter {number} total -- The total number of API calls to make.
 # @parameter {string} key -- The API key to use in the get request.
 # @parameter {array} acc=[] -- The default function accumulator.
 # @returns {array} -- An array of item objects.
###
def fetchItemJson(url, total, key, acc = [])
  total.times do |page|
    page += 1
    opts = {
      "key" => key,
      "page" => page
    }
    items = JSON.parse(HTTP.get(url, :params => opts))

    acc.push(items)

    feedback = "
    Page ##{page} finished downloading.
    #{acc.length} pages downloaded.
    #{total - acc.length} pages left to download.
    "

    print(feedback)
    sleep(1) # Rest for the server.
  end

  return acc.flatten
end


### 
 # Gets and parses item file metadata.
 # @parameter {string} url -- The URL to make the HTTP get request with.
 # @parameter {string} key -- The API key to use in the get request.
 # @returns {hash} -- A hash of the file metadata.
###
def getFileObject(url, key)
  file = JSON.parse(HTTP.get(url, :params => {"key" => key}))

  if file[0]
    file = file[0]
    obj = {
      "Original Filename" => file["original_filename"], 
      "Filename" => file["filename"]
    }
  else
    obj = {
      "Original Filename" => nil, 
      "Filename" => nil
    }
  end

  return obj
end


### 
 # Determines if an item hash has files and returns the first files metadata hash.
 # @parameter {hash} item -- The item hash to check for files.
 # @parameter {string} key -- The API key to use in the get request.
 # @returns {hash} -- A hash of the file metadata.
###
def handleItemFiles(item, key)
  files = item["files"]

  if files
    url = files["url"]
    file = getFileObject(url, key)
  else
    file = {
      "Original Filename" => nil, 
      "Filename" => nil
    }
  end

  return file
end


### 
 # Determines if an item has a type and returns it.
 # @parameter {hash} item -- The item hash to check the type of.
 # @returns {string} -- The item type, or nill if the item has no type.
###
def handleItemType(item)
  type = item["item_type"]
  if type
    type = type["name"]
  end
  
  return type
end


###
 # Given a list of keys and an item hash, returns the values for the given keys.
 # @parameter {array} lok -- A list of keys (lok) that corresponds to the desired output values.
 # @parameter {hash} item -- The item to get the values from.
 # @returns {array} -- An array of values.
###
def getValues(lok, item)
  lok.map {|kee| item[kee]}
end


###
 # Transforms raw item objects into item metadata arrays.
 # @parameter {array} loi -- A list of item objects to transform.
 # @parameter {array} lok -- A list of keys corresponding to the desired item metadata values.
 # @parameter {string} key -- The API key used to fetch file metadata.
 # @parameter {array} init=[] -- The default initial value for the items reduction function.
 # @returns {array} -- An array of item metadata values. The first element is the column headers.
###
def processItemsForCsv(loi, lok, key, init=[])
  items = loi.reduce(init) do |memo, item|
    id = { "ID" => item["id"] }
    type = { "Item Type" => handleItemType(item) }
    pub = { "Public" => item["public"] }
    file = handleItemFiles(item, key)
    elements = item["element_texts"].map {
      |element| { element["element"]["name"] => element["text"] }
    }

    objs = [
      id,
      type,
      pub,
      file,
      elements
    ].flatten
    
    feedback = "
    Item ##{item["id"]} finished processing.
    #{memo.length + 1} items processed.
    #{loi.length - (memo.length + 1)} items left to process.
    "

    print(feedback)
    sleep(1) # Rest for the server.
    
    memo.push(getValues(lok, (objs.reduce({}) {|acc, obj| acc.merge(obj)})))
  end

  return items.unshift(lok)
end


###
 # Given an array, prints each element as a CSV row to a named output.
 # @parameter {array} items -- The item metadata values to print.
 # @parameter {string} name -- The output filepath.
###
def printToCsv(items, name)
  CSV.open(name, "w") do |csv|
    items.each { |item| csv << item }
  end
end


### CONSTANTS ###


TOTAL_ITEMS = 1467.0 # Set here, rather than using 'omeka-total-results' response header.
ITEMS_PER_PAGE = 50.0
CALLS = (TOTAL_ITEMS / ITEMS_PER_PAGE).ceil

API_KEY = OMEKA_SITE_API_KEY
DOMAIN = OMEKA_SITE_DOMAIN
ENDPOINT = "api/items"
BASE = "#{DOMAIN}/#{ENDPOINT}"

OMEKA_ITEM_KEYS = [ # The Metadata fields to include.
  "ID",
  "Public",
  "Item Type",
  "Title",
  "Date",
  "Event Type",
  "Format",
  "Coverage",
  "Convention Type",
  "Region",
  "Subject",
  "Source",
  "Type",
  "Identifier",
  "Original Format",
  "Uniform Title",
  "Status",
  "Text",
  "Transcription",
  "Filename",
  "Original Filename"
]


### VARIABLES ###


items = processItemsForCsv(fetchItemJson(BASE, CALLS, API_KEY), OMEKA_ITEM_KEYS, API_KEY)
outfile = "path/to/outfile.csv"


### EXECUTION ###


printToCsv(items, outfile)


### END ###

