require "front_matter_parser"

projects = [
  {
    name: "Jigsaw Puzzle App",
    subdomain: "jigsaw",
    description: "An older test app used primary to learn and practice devops. Currently incomplete and in rough shape, but I hope to revisit it in the near future after finishing work on Owlflight."
  },
  {
    name: "Non-Existent App",
    subdomain: "none"
  }
]

projects.each do |project|
  Project.find_or_create_by!(project)
end

Dir.glob(Rails.root.join("db/seeds/posts/*.md")).each do |file|
  parsed = FrontMatterParser::Parser.parse_file(file)

  BlogPost.create!(
    title: parsed.front_matter["title"],
    slug: parsed.front_matter["slug"],
    description: parsed.front_matter["description"],
    published_at: Time.zone.parse(parsed.front_matter["published_at"].to_s),
    content: parsed.content
  )
end
