module ApplicationHelper
  def twitter_url_for(url, text)
    link_to "Twitter", "http://twitter.com/share?url=#{url}&text=#{text}", target: '_blank'
  end
end
