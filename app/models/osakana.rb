class Osakana < ActiveRecord::Base
  require 'mechanize'

  def self.mokyun
    agent = Mechanize.new
    page = agent.get('http://k-tai.impress.co.jp/')
    logger.debug page.links[0]
  end
end
