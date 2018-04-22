class Post < ApplicationRecord
  after_initialize :set_slug

  PER_PAGE_COUNT = 10
  PREVIEW_MAX_WORD_COUNT = 40

  def set_slug
    self.slug = self.title ? self.title.parameterize : ""
  end

  def self.get_all(page = 1)
    Post.order(:date => :desc)
  end

  def preview
    if content.split(" ").count <= PREVIEW_MAX_WORD_COUNT
      MarkdownHelper::strip_down(content).strip
    else
      MarkdownHelper::strip_down(content.split(" ").first(PREVIEW_MAX_WORD_COUNT).join(" ") + "...").strip
    end
  end

  def html_content
    MarkdownHelper::render_html content
  end

  def formatted_date
    Time.at(date).to_datetime.strftime("%Y-%m-%d")
  end
end

