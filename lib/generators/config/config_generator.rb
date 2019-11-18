require 'json'

class ConfigGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  # General Config
  class_option :cache, type: :boolean,
               default: true,
               desc: 'Whether to use cached config in ".esaas-engagements-config.yml" if present.
                      Cached values will override defaults and command-line options.'
  class_option :ruby_version, type: :string,
               default: '2.4.5',
               desc: 'Ruby version should match one set in Gemfile.
                      This determines the version of the standard docker ruby image to use.'
  class_option :docker, type: :boolean,
               default: true,
               desc: 'Include Dockerfile and Docker Compose YML'
  class_option :rails_env, type: :string,
               default: 'development',
               desc: 'Sets the RAILS_ENV for the Docker file'
  class_option :doc, type: :boolean,
               default: true,
               desc: 'Include documentation in generated files'

  # Postgresql Config
  class_option :pg_user, type: :string,
               default: '<Randomly generated>',
               desc: 'Postgresql User'
  class_option :pg_pass, type: :string,
               default: '<Randomly generated>',
               desc: 'Postgresql Password'
  class_option :pg_host, type: :string,
               default: 'postgres-server',
               desc: 'Hostname for the Postgres instance.
                      Only useful for production environment.
                      Default "postgres-server" results in the creation of a postgres docker instance.'
  class_option :pg_port, type: :string,
               default: '5432',
               desc: 'Postgresql Port'
  class_option :pg_dbase, type: :string,
               default: 'esass-engagements',
               desc: 'Postgresql Database'
  class_option :pg_vmap, type: :boolean,
               default: false,
               desc: 'Whether to use volume mapping for Postgres Docker instance.
                      Only relevant if "--pg_host" is "postgres-server". Volume maps to Rails.root/tmp/db.'

  # Email Config
  class_option :sendgrid_key, type: :string,
               default: 'SG.SendGrid.mock.key',
               desc: 'SendGrid API Key'

  # Test Environment Config
  class_option  :test_secret_key, type: :string,
                default: '<Randomly generated>',
                desc: 'Test-environment Secret Key Base that is used to encrypt the cookie'
  class_option :test_github_key, type: :string,
               default: '<Randomly generated>',
               desc: 'Test-environment Github Key'
  class_option :test_github_secret, type: :string,
               default: '<Randomly generated>',
               desc: 'Test-environment Github Secret'

  # Dev Environment Config
  class_option  :dev_secret_key, type: :string,
                default: '<Randomly generated>',
                desc: 'Development-environment Secret Key Base that is used to encrypt the cookie'
  class_option :dev_github_key, type: :string,
               default: '<Randomly generated>',
               desc: 'Development-environment Github Key'
  class_option :dev_github_secret, type: :string,
               default: '<Randomly generated>',
               desc: 'Development-environment Github Secret'

  # Prod Environment Config
  class_option  :prod_secret_key, type: :string,
                default: '<Randomly generated>',
                desc: 'Production-environment Secret Key that is used to encrypt the cookie'
  class_option :prod_github_key, type: :string,
               default: '<Randomly generated>',
               desc: 'Production-environment Github Key'
  class_option :prod_github_secret, type: :string,
               default: '<Randomly generated>',
               desc: 'Production-environment Github Secret'

  # AWS S3 Config
  class_option :aws_key_id, type: :string,
                default: '<Randomly generated>',
                desc: 'AWS Secret Key ID'
  class_option :aws_secret_key, type: :string,
               default: '<Randomly generated>',
               desc: 'AWS Secret Access Key'
  class_option :aws_bucket_name, type: :string,
               default: '<Randomly generated>',
               desc: 'AWS S3 Bucket Name'
  class_option :aws_region, type: :string,
               default: 'us-west-1',
               desc: 'AWS Region'
  class_option :aws_host_name, type: :string,
               default: 'minio-s3mock:9000',
               desc: 'S3 Host Name.
                      Default address minio-s3mock:9000 uses Minio available in the docker compose network.'

  def get_config
    if File.exist? Rails.root.join('.esaas-engagements-config.json') and @options[:cache]
      say 'Reading configurations from ' + set_color('.esaas-engagements-config.json', :green, :bold)
      @options = @options.map {|k, v| [k.to_sym, v]}.to_h
      cached_options = JSON.load(Rails.root.join('.esaas-engagements-config.json'))
      cached_options = cached_options.map {|k, v| [k.to_sym, v]}.to_h
      @options.keys.each do |key|
        @options[key] = cached_options[key] if cached_options.key? key
      end
    end

    raise ArgumentError, "Invalid rails_env" unless
        %w(test development production).any? {|s| s == @options[:rails_env]}

    @options = @options.map do |opt, val|
      if val == '<Randomly generated>'
        val = if opt.to_s.start_with? 'pg'
                SecureRandom.hex(16)
              elsif opt.to_s.starts_with? 'prod'
                SecureRandom.hex(128)
              else
                SecureRandom.hex(64)
              end
      end
      [opt.to_sym, val]
    end

    @options = @options.to_h

    # PostgresDSN = postgresql://[user[:password]@][netloc][:port][/dbname][?param1=value1&...]
    @options[:database_url] =
        "postgresql://#{@options[:pg_user]}:#{@options[:pg_pass]}@#{@options[:pg_host]}:#{@options[:pg_port]}/#{@options[:pg_dbase]}"
  end

  def generate_app_config
    template 'application.yml.template', 'config/application.yml'
    if @options[:docker]
      template 'Dockerfile.template', 'Dockerfile'
      template 'docker-compose.yml.template', 'docker-compose.yml'
    end

    # Cache config
    File.open(Rails.root.join('.esaas-engagements-config.json'), "w") do |file|
      file.write(JSON.pretty_generate(@options.except(:database_url)))
    end
  end
end
