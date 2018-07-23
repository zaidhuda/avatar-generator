class DocsController < ApplicationController
  def index
    @image_url = img_url(params: avatar_params)
  end

  def options
  end

  def examples
    @examples = {
                  name: 'Avatar Generator',
                  size: 128,
                  color: 'orange',
                  bg: 'orange',
                  ratio: 70,
                  rounded: true
                }
  end

  private

  def avatar_params
    params.permit(:name, :size, :color, :bg, :ratio, :rounded)
          .reject{|_, v| v.blank?}
  end
end
