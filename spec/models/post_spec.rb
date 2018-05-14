require "rails_helper"

RSpec.describe Post, :type  => :model do
  context "at creation" do
    it "saves the title and content" do
      post = Post.create(:title => "this is title", :content => "this is content")
      expect(post.title).to eq "this is title"
      expect(post.content).to eq "this is content"
    end

    it "generates a slug" do
      Post.create(:title => "this is a title", :content => "this is content")
      expect(Post.last.slug).to eq "this-is-a-title"
    end

    it "requires a title" do
      Post.create(:content => "this is content").should_not be_valid
    end

    it "requires a content" do
      Post.create(:title => "this is title").should_not be_valid
    end
  end

  context "querying posts" do
    it "returns most recent posts first" do
      Post.create(:title => "title1", :content => "content1")
      Post.create(:title => "title2", :content => "content2")
      
      all_posts = Post.get_all

      expect(all_posts[0].id).to be < all_posts[1].id
    end

    it "can be queried by slug" do
      post = Post.create(:title => "this is a slug", :content => "content")

      expect(Post.find_by_slug("this-is-a-slug").id).to eq post.id
    end
  end

  context "formatting" do
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
                                :content => ("a " * Post::PREVIEW_MAX_WORD_COUNT).strip)
          short_post.preview.should eq short_post.content
        end
      end
    end

    it "returns the date in the right format" do
      date = DateTime.new(2018, 02, 28).to_time.to_i
      post = Post.new(:date => date)
      post.formatted_date.should eq "2018-02-28"
    end

    it "returns valid html from markdown content" do
      post = Post.new(:content => "# this is a title")
      expect(post.html_content).to include("<h1>")

      post2 = Post.new(:content => "## this is a sub")
      expect(post2.html_content).to include("<h2>")
    end
  end
end
