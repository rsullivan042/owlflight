# OwlFlight

A personal portfolio and blog built with Ruby on Rails. Features a public-facing site with projects, blog posts, and an about page, backed by a password-protected admin dashboard for content management.

Live at [owlflight.dev](https://owlflight.dev).

## Tech Stack

- **Framework:** Ruby on Rails 8, Ruby 3.4
- **Database:** PostgreSQL
- **Frontend:** Tailwind CSS v4, Hotwire (Turbo + Stimulus), Importmap
- **Web server:** Puma + Nginx
- **Process management:** systemd
- **CI/CD:** GitHub Actions (RSpec test suite → deploy on pass)
- **Security analysis:** Brakeman, RuboCop

## Features

- **Projects** — portfolio of apps with descriptions, tech stack, and task tracking
- **Blog** — Markdown-based posts with front matter for metadata
- **Admin dashboard** — HTTP basic auth–protected interface for managing projects, tasks, and blog posts
- **Test suite** — RSpec with FactoryBot, SimpleCov (90% minimum coverage), and Capybara system tests

## Development Setup

**Requirements:** Ruby 3.4.2, PostgreSQL

```bash
git clone https://github.com/rsullivan042/owlflight.git
cd owlflight
bundle install
cp .env.example .env  # add ADMIN_USERNAME and ADMIN_PASSWORD
bin/rails db:setup
bin/dev
```

## Running Tests

```bash
bundle exec rspec
```

## Environment Variables

| Variable         | Description                        |
|------------------|------------------------------------|
| `DB_USERNAME`    | PostgreSQL username                |
| `DB_PASSWORD`    | PostgreSQL password                |
| `ADMIN_USERNAME` | HTTP basic auth username for admin |
| `ADMIN_PASSWORD` | HTTP basic auth password for admin |
| `PUMA_PORT`      | Port for the Puma web server       |
