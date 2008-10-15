# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def tag_cloud(tags, classes)
    return if tags.empty?
    
    max_count = tags.sort_by(&:count).last.count.to_f
    
    tags.each do |tag|
      index = ((tag.count / max_count) * (classes.size - 1)).round
      yield tag, classes[index]
    end
  end
  
  def encode_url(text)
    u(text).gsub(/%20/,'+')
  end
  
  def decode_url(text)
    CGI::unescape(text.gsub(/\+/,'%20'))
  end
  
end
