##
# Authors: Michelle Byrnes
# Name: jekyll_prompts_generator
# Summary: A Jekyll generator that produces pages from site data files.
module DataFileToPrompt
  class PromptsGenerator < Jekyll::Generator
    priority :low

    def generate(site)
      site.data["prompts"].each do |prompt|
        prompt = Prompt.new(site, prompt)
        
        site.pages << PromptPage.new(site, prompt)
      end
    end
  end

  class PromptPage < Jekyll::Page
    def initialize(site, prompt)
      @site = site
      @base = site.source
      @dir = prompt.title.split.join("-")
      @basename = "index"
      @ext = ".html"
      @name = @basename + @ext

      @data = {
        "category" => "prompts",
        "id" => prompt.id,
        "title" => prompt.title,
        "question" => prompt.question,
        "input" => prompt.input,
        "output" => prompt.output,
        "source" => prompt.source,
        "solutions" => prompt.solutions
      }

      data.default_proc = proc do |_, key|
        site.frontmatter_defaults.find(relative_path, :prompts, key)
      end
    end
    
    def url_placeholders
      {
        :prompt   => @dir,
        :basename   => basename,
        :output_ext => output_ext,
      }
    end
  end

  class Prompt
    attr_accessor :id, :title, :question, :input, :output, :source, :solutions
    def initialize(site, prompt)
      @id = prompt["prompt_id"]
      @title = prompt["prompt_title"]
      @question = prompt["prompt_question"]
      @input = prompt["prompt_input"]
      @output = prompt["prompt_output"]
      @source = prompt["prompt_source"]
      @solutions = site.data["solutions"].select{|solution| solution["prompt_id"] == @id}
    end
  end
end