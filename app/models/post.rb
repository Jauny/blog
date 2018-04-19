class Post < ApplicationRecord
  after_initialize :set_slug

  PREVIEW_MAX_WORD_COUNT = 40

  def set_slug
    self.slug = self.title ? self.title.parameterize : ""
  end

  def self.get_all
    Post.order(:created_at => :desc)
  end

  def preview
    if content.split(" ").count <= PREVIEW_MAX_WORD_COUNT
      content
    else
      content.split(" ").first(PREVIEW_MAX_WORD_COUNT).join(" ") + "..."
    end
  end
end
