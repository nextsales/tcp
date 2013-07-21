module MatricesHelper
  def hello_world(name)
      "hello #{name}"
  end
  
  def render_linkedin_feed_content(data)
    feed = ActiveSupport::JSON.decode(data)
    feed["update_content"]
  end
end
