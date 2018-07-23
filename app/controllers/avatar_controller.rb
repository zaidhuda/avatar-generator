class AvatarController < ApplicationController
  def index
    avatar = Avatar.new(avatar_params)
    send_data(IO.read(avatar.file_path),
              filename: "#{avatar.cache_key}.png",
              type: 'image/png',
              disposition: 'inline')
  rescue Errno::ENOENT
    return index if avatar.save
  end

  private

  def avatar_params
    cleaned_params = params.reject{|_, v| v.blank?}
    {
      name: cleaned_params.fetch(:name, 'John Doe'),
      size: cleaned_params.fetch(:size, 64),
      color: cleaned_params.fetch(:color, 'white'),
      bg: cleaned_params.fetch(:bg, nil),
      ratio: cleaned_params.fetch(:ratio, 45),
      rounded: cleaned_params.fetch(:rounded, false)
    }
  end
end
