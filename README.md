# FlutterApp

A modern Rails 8.0 application with Stimulus, Turbo, and Kamal deployment.

## Requirements

* Ruby 3.3.4 (see `.ruby-version`)
* SQLite3 (development/test)
* Docker (for deployment)

## Setup

1. Clone the repository
2. Install dependencies and set up the database:
   ```bash
   bin/setup
   ```

The setup script will automatically start the development server unless you pass `--skip-server`.

## Development

Start the development server:
```bash
bin/dev
```

The application will be available at http://localhost:3000

### Code Quality & Security

* **Linting**: Run `bin/rubocop` for Ruby style checking
* **Security**: Run `bin/brakeman` for security vulnerability analysis
* **Tests**: Run `bin/rails test` for the test suite
* **Console**: Use `bin/rails console` for interactive debugging

## Features

* **Rails 8.0.2**: Latest Rails with modern defaults
* **Stimulus & Turbo**: Hotwire for interactive frontend without complex JavaScript
* **Import Maps**: Modern JavaScript without bundling
* **Solid Queue**: Database-backed job processing (runs in Puma process)
* **Solid Cache**: Database-backed caching
* **Solid Cable**: Database-backed Action Cable
* **Modern Browser Support**: Requires browsers with webp, web push, import maps, CSS nesting, and CSS :has support
* **PWA Ready**: Progressive Web App capabilities included

## Deployment

This application is configured for deployment with Kamal:

```bash
bin/kamal deploy
```

### Deployment Configuration

* **Service**: flutter_app
* **SSL**: Automatic Let's Encrypt certificates
* **Storage**: Persistent volume for SQLite and Active Storage
* **Jobs**: Solid Queue runs inside Puma (single server setup)

See `config/deploy.yml` for full deployment configuration.

### Kamal Commands

* `bin/kamal console` - Rails console on production
* `bin/kamal shell` - Shell access to production container
* `bin/kamal logs` - Tail application logs
* `bin/kamal dbc` - Database console on production

## Architecture

* **Database**: SQLite3 with Solid adapters for cache/queue/cable
* **Assets**: Propshaft asset pipeline
* **Server**: Puma web server with Thruster for HTTP caching
* **Frontend**: Stimulus controllers with Turbo for SPA-like experience

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run `bin/rubocop` and `bin/brakeman`
5. Run the test suite with `bin/rails test`
6. Submit a pull request
