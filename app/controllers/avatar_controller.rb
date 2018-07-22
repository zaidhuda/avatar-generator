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
    {
      name: params.fetch(:name, 'John Doe'),
      size: params.fetch(:size, 64),
      color: params.fetch(:color, 'white'),
      bg: params.fetch(:bg, nil),
      ratio: params.fetch(:ratio, 45),
      rounded: params.fetch(:rounded, false)
    }
  end
end
