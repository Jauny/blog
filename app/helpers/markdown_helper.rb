module MarkdownHelper
  require "redcarpet"
  require "rouge"
  require "rouge/plugins/redcarpet"

  class HTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end

  def render_html(md)
    options = {
        filter_html:     true,
        hard_wrap:       true,
        link_attributes: { rel: 'nofollow', target: "_blank" },
        space_after_headers: true
      }

      extensions = {
        autolink:           true,
        highlight:          true,
        superscript:        true,
        fenced_code_blocks: true
      }

      renderer = HTML.new(options)
      markdown = Redcarpet::Markdown.new(renderer, extensions)

      markdown.render(md).html_safe
  end
end
