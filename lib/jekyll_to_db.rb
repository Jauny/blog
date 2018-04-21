require "date"

def get_title_from_path(path)
  date = File.basename(path)[0..9]
  date
end

def parse_file(path)
  parsing_meta_data = false
  has_parsed_meta = false
  meta_data = {
    date: get_title_from_path(path)
  }
  content = []

  file = File.open(path)
  file.each_line.with_index do |line, index|
    if line.strip.chars.uniq[0] == "-" && line.strip.chars.uniq.count == 1 && !has_parsed_meta
      if parsing_meta_data
        has_parsed_meta = true
      end
      parsing_meta_data = !parsing_meta_data
      next
    end

    if parsing_meta_data
      meta_data[line.split(":")[0].strip] = line.split(":")[1].strip
    else
      content << line
    end
  end
  [meta_data, content.join]
end

def create_post(meta, content)
  puts meta
  date = meta["date"]
  if date
    date = Date.strptime(date, "%Y-%m-%d").to_time.to_i
  else
    puts "didnt find date in meta"
    date = Time.now.to_i
  end
  Post.create!(:title => meta.fetch("title"),
              :date => date,
              :content => content)
end

def parse_files(dir_path)
  accepted_extensions = ['.md', '.markdown']
  Dir.new(dir_path).each do |file|
    if accepted_extensions.include? File.extname(file)
      meta, content = parse_file(File.join(dir_path, file))
      create_post(meta, content)
    end
  end
end

def clean_posts
  Post.all.each do |p|
    p.content = p.content.join
    p.save
  end
end

parse_files(ARGV[0])
