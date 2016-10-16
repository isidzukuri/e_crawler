module ProductDecorator
  def photos
    JSON.parse(images) if images.present?
  end

  def thumb
    photos.first if photos.present?
  end
end
