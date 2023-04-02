require 'openssl'

provides :certbot

property :domain, String
property :account, String

action :create do
  private_key = OpenSSL::PKey::EC.new('prime256v1')

  package 'httpd'

  service 'httpd' do
    action [:enable, :start]
  end

  file '/var/www/html/index.html' do
    content new_resource.homepage
  end
end

action :delete do
  package 'httpd' do
    action :remove
  end

  file '/var/www/html/index.html' do
    action :delete
  end
end
