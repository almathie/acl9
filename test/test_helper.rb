require 'rubygems'
require 'bundler/setup'
require 'matchy'
require 'active_support'
require 'active_record'
require 'test/unit'
require 'action_controller'
require 'turn'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => 'test.sqlite3')

class Test::Unit::TestCase
  custom_matcher :be_false do |receiver, matcher, args|
    !receiver
  end

  custom_matcher :be_true do |receiver, matcher, args|
    !!receiver
  end
end

ActionDispatch::Routing::Routes.draw do |map|
  map.connect ":controller/:action/:id"
end

ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")
ActionController::Base.logger = ActiveRecord::Base.logger
ActiveRecord::Base.silence { ActiveRecord::Migration.verbose = false }
