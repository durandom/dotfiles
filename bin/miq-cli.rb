#!/usr/bin/env ruby

require 'rubygems'
require 'manageiq-api-client'
require 'optparse'
require 'awesome_print'


options = {
    url: 'http://localhost:3000'
}
OptionParser.new do |opts|
  opts.banner = 'miq-cli.rb [options]'
  opts.on("-h", "--help") do
    puts opts
    exit
  end
  opts.on("-u URL", "url to connect to, defaults to #{options[:url]}") do |url|
    options[:url] = url
  end
  opts.on("-p PROVIDER", "provider to use") do |provider|
    options[:provider] = provider
  end
  opts.on("-c", "create provider") do |create|
    options[:create] = true
  end
end.parse!


class MiqCli
  attr_accessor :options
  def initialize(options)
    @options = options
  end

  def client
    ManageIQ::API::Client.new(
        :url      => options[:url],
        :ssl      => {verify: false},
        # :logger   => Logger.new(STDOUT),
        :user     => "admin",
        :password => "smartvm"
    )
  end

  def providers
    client.providers.each do |p|
      puts "#{p.id} - #{p.name} (#{p.provider_region if p.respond_to? :provider_region})"
    end
  end

  def providers_create_azure
    client.providers.create(
        {
            name: "azure-hild",
            type: "ManageIQ::Providers::Azure::CloudManager",
            provider_region: 'westeurope',
            tenant_id: '',
            subscription: '',
            credentials: [
                {
                    userid: '',
                    password: ''
                }
            ]
        }
    )
  end

  def providers_create_amazon
    # client.providers.create(
    #     {
    #         name: "aws-hild",
    #         type: "ManageIQ::Providers::Amazon::CloudManager",
    #         provider_region: 'eu-central-1',
    #         credentials: [
    #                   {
    #                       userid: '',
    #                       password: ''
    #                   }
    #               ]
    #     }
    # )
    client.providers.create(
        {
            name: "aws-qe",
            type: "ManageIQ::Providers::Amazon::CloudManager",
            provider_region: 'us-east-1',
            credentials: [
                {
                    userid: '',
                    password: ''
                }
            ]
        }
    )
  end
end

cli = MiqCli.new(options)

puts "current providers:"
cli.providers

if options[:create]
  cli.public_send("providers_create_#{options[:provider]}")

  puts "after create"
  cli.providers
end

