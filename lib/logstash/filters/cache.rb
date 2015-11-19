# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"

# This filter provide a cache where you can store data.
#
class LogStash::Filters::Cache < LogStash::Filters::Base

  # The config looks like this:
  #
  #     filter {
  #       cache {
  #         key => "YYYY"
  #         value => "XXXX"
  #         get => "boolean"
  #         field => "ZZZZZ"
  #       }
  #     }
  #
  # The `field` is the field you want added to the event.
  config_name "cache"
 
  # This filter needs to keep state.
  @@cachetab = Hash.new

  # The key for the data you want to store or retrieve
  config :key, :validate => :string, :required => true

  # The value for the data you want to store or retrieve
  config :value, :validate => :string, :required => false

  # Sets the action. If set to true, it will get the data from cache
  config :get, :validate => :boolean, :default => false

  # The field where the value be set for get => "true"
  config :field, :validate => :string, :required => false, :default => "cache_value"

  public
  def register
    # Nothing
    @threadsafe = false
  end # def register

  public
  def filter(event)
    if @get
      event[@field] = @@cachetab[@key]
      if event[@field] == nil
        event["tags"] ||= []
        event["tags"] << "cache_miss" unless event["tags"].include?("cache_miss")
      else
        # filter_matched should go in the last line of our successful code
        filter_matched(event)
      end
    else
      @@cachetab[@key]= event.sprintf(@value)
      # filter_matched should go in the last line of our successful code
      filter_matched(event)
    end

  end # def filter
end # class LogStash::Filters::Cache
