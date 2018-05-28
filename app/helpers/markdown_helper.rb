module MarkdownHelper
  require "redcarpet"
  require 'redcarpet/render_strip'
  require "rouge"
  require "rouge/plugins/redcarpet"

  class HTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end

  def self.render_html(md)
    options = {
        hard_wrap:       true,
        link_attributes: { rel: 'nofollow', target: "_blank" },
        space_after_headers: true
      }

      extensions = {
        autolink:           true,
        highlight:          true,
        superscript:        true,
        fenced_code_blocks: true,
        tables:             true
      }

      renderer = HTML.new(options)
      markdown = Redcarpet::Markdown.new(renderer, extensions)

      markdown.render(md).html_safe
  end

  def self.strip_down(md)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::StripDown)
    markdown.render(md)
  end
end
