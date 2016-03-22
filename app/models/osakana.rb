class Osakana < ActiveRecord::Base
  require 'mechanize'

  @zukan_url = "http://zukan.com/fish/"

  def self.zukan_crawl(zukan_page_max)
    agent = Mechanize.new
    self.zukan_insert(agent, 1)

    (1..zukan_page_max).each {|num|
      self.zukan_insert(agent, num)
    }
  end

  private
  def self.zukan_insert(agent, page_number)
    resource = @zukan_url  + "internal" + page_number.to_s

    begin
      page = agent.get(resource)
    rescue Mechanize::ResponseCodeError => e
      return
    end

    h1 = page.search("#nodeHeadTitle h1")
    name = h1[0]["title"]

    if self.where(name: name).count != 0
      return
    end

    new_osakana = self.new(name: name)

    table = page.search("#description_view_toggle section table tbody tr")
    table.each {|elm|
      th = elm.css("th")[0].text
      td = elm.css("td")[0].text

      case th
      when "特徴" then
        new_osakana.information = td
      when "形態・特徴" then
        new_osakana.information = td
      when "分布" then
        new_osakana.map = td
      when "生息環境" then
        new_osakana.ecology = td
      when "食性" then
        new_osakana.food = td
      when "その他" then
        new_osakana.extra = td
      else
      end
    }

    new_osakana.save
  end

end
