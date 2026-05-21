namespace :blog do
  desc "Export blog posts to markdown files"

  task export: :environment do
    output_dir = Rails.root.join("blog_exports")
    count = 0

    FileUtils.mkdir_p(output_dir)

    BlogPost.find_each do |post|
      filename = "#{post.published_at.to_date}-#{post.slug}.md"

      content = <<~MARKDOWN
        ---
        title: #{post.title}
        slug: #{post.slug}
        description: #{post.description}
        published_at: #{post.published_at}
        ---

        #{post.content}
      MARKDOWN

      File.write(output_dir.join(filename), content)
      count += 1
    end

    puts "#{count} posts exported."
  end

  task import: :environment do
    count = 0

    Dir.glob(Rails.root.join("blog_exports/*.md")).each do |file|
      parsed = FrontMatterParser::Parser.parse_file(file)

      BlogPost.find_or_initialize_by(
        slug: parsed.front_matter["slug"]
      ).tap do |post|
        post.title = parsed.front_matter["title"]
        post.description = parsed.front_matter["description"]
        post.published_at = parsed.front_matter["published_at"]
        post.content = parsed.content

        post.save!
        count += 1
      end
    end

    puts "#{count} posts imported."
  end
end
