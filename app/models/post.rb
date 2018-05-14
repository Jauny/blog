class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  after_create :set_slug, :set_date

  PER_PAGE_COUNT = 10
  PREVIEW_MAX_WORD_COUNT = 40

  def self.get_all(page = 1)
    Post.order(:date => :desc)
  end

  def to_param
    slug
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
    Time.zone.at(date).strftime("%Y-%m-%d")
  end

  private
  def set_slug
    self.slug = self.title.parameterize
    self.save
  end

  def set_date
    self.date = Time.zone.now.strftime("%s")
    self.save
  end
end

