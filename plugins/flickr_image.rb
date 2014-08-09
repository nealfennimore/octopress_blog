require 'flickraw'
class FlickrImage < Liquid::Tag
 
  def initialize(tag_name, markup, tokens)
     super
     @markup = markup
     @id   = markup.split(' ')[0]
     @size = markup.split(' ')[1]
  end
 
  def render(context)
 
    FlickRaw.api_key        = ENV["FLICKR_KEY"]
    FlickRaw.shared_secret  = ENV["FLICKR_SECRET"]
 
    info = flickr.photos.getInfo(:photo_id => @id)
 
    server        = info['server']
    farm          = info['farm']
    id            = info['id']
    secret        = info['secret']
    title         = info['title']
    description   = info['description']
    size          = "_#{@size}" if @size
    src           = "http://farm#{farm}.static.flickr.com/#{server}/#{id}_#{secret}#{size}.jpg"
    page_url      = info['urls'][0]["_content"]
 
    img_tag       = "<img src='#{src}' title='#{title}'/>"
    link_tag      = "<a href='#{page_url}'>#{img_tag}</a>"
 
  end
end
 
Liquid::Template.register_tag('flickr_image', FlickrImage)