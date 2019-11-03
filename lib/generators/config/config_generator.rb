class ConfigGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  class_option :docker, type: :boolean,
               default: true,
               desc: 'Include Dockerfile and Docker Compose YML'
  class_option :doc, type: :boolean,
               default: true,
               desc: 'Include documentation'
  class_option :tls, type: :boolean,
               default: false,
               desc: 'Enable TLS configuration for Docker Compose Setup.
                      If set to true, --x509_cert and --x509_key should also be provided.'
  class_option :ruby_version, type: :string,
               default: '2.4.5',
               desc: 'Ruby version should match one set in Gemfile.
                      This determines the version of the standard docker ruby image to use.'
  class_option :rails_env, type: :string,
               default: 'development',
               desc: 'Sets the RAILS_ENV for the Docker file'

  class_option :sendgrid_key, type: :string,
               default: 'SG.SendGrid.mock.key',
               desc: 'SendGrid API Key'
  class_option  :test_secret_key, type: :string,
                default: '<Randomly generated>',
                desc: 'Test-environment Secret Key Base that is used to encrypt the cookie'
  class_option :test_github_key, type: :string,
               default: '<Randomly generated>',
               desc: 'Test-environment Github Key'
  class_option :test_github_secret, type: :string,
               default: '<Randomly generated>',
               desc: 'Test-environment Github Secret'

  class_option  :dev_secret_key, type: :string,
                default: '<Randomly generated>',
                desc: 'Development-environment Secret Key Base that is used to encrypt the cookie'
  class_option :dev_github_key, type: :string,
               default: '<Randomly generated>',
               desc: 'Development-environment Github Key'
  class_option :dev_github_secret, type: :string,
               default: '<Randomly generated>',
               desc: 'Development-environment Github Secret'

  class_option  :prod_secret_key, type: :string,
                default: '<Randomly generated>',
                desc: 'Production-environment Secret Key that is used to encrypt the cookie'
  class_option :prod_github_key, type: :string,
               default: '<Randomly generated>',
               desc: 'Production-environment Github Key'
  class_option :prod_github_secret, type: :string,
               default: '<Randomly generated>',
               desc: 'Production-environment Github Secret'

  class_option :aws_key_id, type: :string,
                default: '<Randomly generated>',
                desc: 'AWS Secret Key ID'

  class_option :aws_secret_key, type: :string,
               default: '<Randomly generated>',
               desc: 'AWS Secret Access Key'

  class_option :aws_bucket_name, type: :string,
               default: '<Randomly generated>',
               desc:                                           'AWS S3 Bucket Name'

  class_option :aws_region, type: :string,
               default: 'us-west-1',
               desc: 'AWS Region'

  class_option :aws_host_name, type: :string,
               default: 'minio-s3mock:9000',
               desc: 'S3 Host Name.
                      Default address minio-s3mock:9000 uses Minio available in the docker compose network.'

  def get_config
    raise ArgumentError "Invalid rails_env" unless
        %w(test development production).any? {|s| s == @options[:rails_env]}

    @options = @options.map do |opt, val|
      val = SecureRandom.hex(64) if val == '<Randomly generated>'
      [opt.to_sym, val]
    end
    @options = @options.to_h
    puts @options
  end

  def generate_app_config
    template 'application.yml.template', 'config/application.yml'
    if @options[:docker]
      template 'Dockerfile.template', 'Dockerfile'
      template 'docker-compose.yml.template', 'docker-compose.yml'
    end
  end
end
