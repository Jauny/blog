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

  context "preview" do
    context "when the content is longer that preview max length" do
      let (:post) { Post.new(:title => "a post",
                             :content => "word " * Post::PREVIEW_MAX_WORD_COUNT * 2 )}

      it "shortens the preview to #{Post::PREVIEW_MAX_WORD_COUNT} words" do
        post.preview.split(" ").count.should eq Post::PREVIEW_MAX_WORD_COUNT
      end

      it "adds an ellipsis at the end" do
        post.preview.chars.last(3).join.should eq "..."
      end
    end

    context "when the content is less than preview max length" do
      it "returns the content" do
        short_post = Post.new(:title => "a short post",
                              :content => "a " * Post::PREVIEW_MAX_WORD_COUNT)
        short_post.preview.should eq short_post.content
      end
    end
  end
end
