##
# Authors: Michelle Byrnes
# Name: jekyll_print_filters
# Summary: Jekyll filter that prints a code file given its name.
##
# Descriptions:
#   print_code: file_name -> file_contents
#   ext_to_lang: ext_name -> "Language Name"
module Jekyll
  module PrintCodeFilters
    CODE_SAMPLE_END_OF_LIST = %r!\]\,!.freeze
    CODE_SAMPLE_OPENING_PAREN = %r!\[\s!.freeze
    CODE_SAMPLE_CLOSING_PAREN = %r!\s\]!.freeze
    
    def print_code(input)
      IO.read("_code_files/#{input}")
    end
    
    def ext_to_lang(input)
      case input
        when ".rb"
          "Ruby"
        when ".java"
          "Java"
        when ".js"
          "JavaScript"
        else "Ruby"
      end
    end

    def print_sample(input)
      input.gsub(CODE_SAMPLE_END_OF_LIST, "],<br>")
      .gsub(CODE_SAMPLE_OPENING_PAREN, "[<br>")
      .gsub(CODE_SAMPLE_CLOSING_PAREN, "<br>]")
    end
  end
end

Liquid::Template.register_filter(Jekyll::PrintCodeFilters)
