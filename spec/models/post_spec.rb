require "rails_helper"

RSpec.describe Post, :type  => :model do
  context "at creation" do
    it "saves with a title and a content" do
      post = Post.new(:title => "this is title", :content => "this is content")
      expect(post.title).to eq "this is title"
      expect(post.content).to eq "this is content"
    end

    it "generates a slug" do
      Post.create(:title => "this is a title")
      expect(Post.last.slug).to eq "this-is-a-title"
    end

    it "generates an empty slug when title is empty" do
      Post.create
      expect(Post.last.slug).to eq ""
    end
  end

  context "querying posts" do
    it "returns posts sorted by creation date descending" do
      post1 = Post.create
      post2 = Post.create
      
      all_posts = Post.get_all

      expect(all_posts[0].created_at).to be > all_posts[1].created_at
    end

    it "can be done by slug" do
      post = Post.create(:title => "this is a slug")

      expect(Post.find_by_slug("this-is-a-slug").id).to eq post.id
    end
  end
end
