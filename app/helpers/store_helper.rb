module StoreHelper

  def layout_options
    [
      ['Default', 'default'],
      ['Portrait', 'portrait'],
      ['List', 'list']
    ]
  end

  def background_photos
    if current_store.background_images.count > 0
      current_store.background_images.collect{|i|{image: i.photo.url}}.to_json.html_safe
    else
      default_images
    end
  end

private

  def default_images
  [
    {image: 'http://farm9.staticflickr.com/8348/8154926648_4cb361d8ce_k.jpg'},
    {image: 'http://i.imgur.com/Fgs1WK4.jpg'}
    ].to_json.html_safe
  end
end
