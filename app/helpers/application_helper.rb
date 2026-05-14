module ApplicationHelper
  def navbar_links
    [
      { text: "Home", path: root_path },
      { text: "Projects", path: projects_path },
      { text: "Blog", path: blog_path },
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
end
