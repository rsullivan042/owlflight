module ApplicationHelper
  def navbar_links
    [
      { text: "Home", path: root_path },
      { text: "Projects", path: projects_path },
      { text: "Blog", path: blog_posts_path },
      { text: "About Me", path: about_me_path }
    ]
  end

  def admin_navbar_links
    navbar_links = [
        { text: "Dashboard", path: admin_root_path },
        { text: "Projects", path: admin_projects_path },
        { text: "Blog", path: admin_blog_posts_path },
        { text: "Main Site", path: root_path }
      ]

    if Project.current
      navbar_links.insert(
        2,
        { text: "Tasks", path: admin_project_tasks_path(Project.current) }
      )
    end

    navbar_links
  end

  def nav_link_classes(path)
    base = "button_top"

    if current_page?(path)
      "#{base} text-amber-300 border-amber-400"
    else
      "#{base} button_top_inactive text-stone-400 border-transparent hover:text-stone-100 hover:border-stone-600"
    end
  end

  def admin_namespace?
    controller_path.start_with?("admin/")
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
