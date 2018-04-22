class Post < ApplicationRecord
  after_initialize :set_slug

  PER_PAGE_COUNT = 10
  PREVIEW_MAX_WORD_COUNT = 40

  def set_slug
    self.slug = self.title ? self.title.parameterize : ""
  end

  def self.get_all
    Post.order(:date => :desc)
  end

  def preview
    if content.split(" ").count <= PREVIEW_MAX_WORD_COUNT
      MarkdownHelper::strip_down content
    else
      MarkdownHelper::strip_down content.split(" ").first(PREVIEW_MAX_WORD_COUNT).join(" ") + "..."
    end
  end

  def html_content
    MarkdownHelper::render_html content
  end

  def formatted_date
    Time.at(date).to_datetime.strftime("%Y-%m-%d")
  end

  def format_markdown(md)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true, :fenced_code_blocks => true)
    markdown.render(md)
  end
end

