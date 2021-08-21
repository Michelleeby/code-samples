##
# Authors: Michelle Byrnes
# Creator: Jekyll Team
# Name: jekyll_variable_highlight_block
# Summary: The built-in Jekyll Highlighter but accepts a liquid variable as input.
##
# Description:
# A version of the built in highlight tag. This only accepts a Liquid variable as input.
# Features like variable line numbers are not functional with this tag block.
module Jekyll
  class VariableHighlightBlock < Liquid::Block
    include Liquid::StandardFilters

    VARIABLE_SYNTAX = %r!
    (?<variable>[^{]*(\{\{\s*[\w\-.]+\s*(\|.*)?\}\}[^\s{}]*)+)
    !mx.freeze

    def initialize(tag_name, markup, tokens)
      super
      markup = markup.strip
      matched = markup.match(VARIABLE_SYNTAX)
      @raw_variable = matched["variable"].strip
    end

    def render_variable(context, var)
      Liquid::Template.parse(var).render(context)
    end

    LEADING_OR_TRAILING_LINE_TERMINATORS = %r!\A(\n|\r)+|(\n|\r)+\z!.freeze

    def render(context)
      prefix = context["highlighter_prefix"] || ""
      suffix = context["highlighter_suffix"] || ""
      code = super.to_s.gsub(LEADING_OR_TRAILING_LINE_TERMINATORS, "")
      @lang = render_variable(context, @raw_variable)

      output =
        case context.registers[:site].highlighter
        when "rouge"
          render_rouge(code)
        when "pygments"
          render_pygments(code, context)
        else
          render_codehighlighter(code)
        end

      rendered_output = add_code_tag(output)
      prefix + rendered_output + suffix
    end

    private

    def render_pygments(code, _context)
      Jekyll.logger.warn "Warning:", "Highlight Tag no longer supports rendering with Pygments."
      Jekyll.logger.warn "", "Using the default highlighter, Rouge, instead."
      render_rouge(code)
    end

    def render_rouge(code)
      require "rouge"
      formatter = ::Rouge::Formatters::HTMLLegacy.new(
        :line_numbers => false,
        :wrap         => false,
        :css_class    => "highlight",
        :gutter_class => "gutter",
        :code_class   => "code"
      )
      lexer = ::Rouge::Lexer.find_fancy(@lang, code) || Rouge::Lexers::PlainText
      formatter.format(lexer.lex(code))
    end

    def render_codehighlighter(code)
      h(code).strip
    end

    def add_code_tag(code)
      code_attributes = [
        "class=\"language-#{@lang.to_s.tr("+", "-")}\"",
        "data-lang=\"#{@lang}\"",
      ].join(" ")
      "<figure class=\"highlight\"><pre><code #{code_attributes}>"\
      "#{code.chomp}</code></pre></figure>"
    end
  end
end

Liquid::Template.register_tag("variable_highlight", Jekyll::VariableHighlightBlock)
