require "logger"
require "net/http"
require "gcore_api_rb/version"
require "gcore_api/client"
require "gcore_api/errors"

module GcoreApi
  @api_base = 'https://api.gcdn.co'
  @log_level = nil
  @logger = Logger.new(STDOUT)
  @max_network_retries = 0
  @secret_key = nil
  @tokens_file_name = 'gcore_api_tokens'

  class << self
    attr_accessor :username
    attr_accessor :password
    attr_accessor :max_network_retries
    attr_accessor :secret_key

    attr_reader :api_base
    attr_reader :tokens_file_name
  end

  LEVEL_DEBUG = Logger::DEBUG
  LEVEL_ERROR = Logger::ERROR
  LEVEL_INFO = Logger::INFO

  def self.log_level
    @log_level
  end

  def self.log_level=(val)
    if val == 'debug'
      val = LEVEL_DEBUG
    elsif val == 'info'
      val = LEVEL_INFO
    end

    if !val.nil? && ![LEVEL_DEBUG, LEVEL_ERROR, LEVEL_INFO].include?(val)
      raise ArgumentError, 'log_level should only be set to `nil`, `debug` or `info`'
    end

    @log_level = val
  end

  def self.logger
    @logger
  end

  def self.logger=(val)
    @logger = val
  end

  def self.client
    @client ||= Client.new
  end
end