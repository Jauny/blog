class Post < ApplicationRecord
  after_initialize :set_slug

  def set_slug
    self.slug = self.title ? self.title.parameterize : ""
  end

  def self.get_all
    Post.order(:created_at => :desc)
  end
end
