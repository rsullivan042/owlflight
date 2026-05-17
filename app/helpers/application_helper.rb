module ApplicationHelper
  def navbar_links
    [
      { text: "Home", path: root_path },
      { text: "Projects", path: projects_path },
      { text: "Blog", path: blog_posts_path },
      { text: "About Me", path: about_me_path }
    ]
  end

  def nav_link_classes(path)
    base = "button_top"

    if current_page?(path)
      "#{base} text-amber-300 border-amber-400"
    else
      "#{base} button_top_inactive text-stone-400 border-transparent hover:text-stone-100 hover:border-stone-600"
    end
  end

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(
      filter_html: true,
      hard_wrap: true
    )

    markdown = Redcarpet::Markdown.new(
      renderer,
      fenced_code_blocks: true,
      tables: true,
      autolink: true,
      strikethrough: true
    )

    markdown.render(text).html_safe
  end
end
