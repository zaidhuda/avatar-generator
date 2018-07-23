class Avatar
  attr_accessor :name
  attr_accessor :size
  attr_accessor :color
  attr_accessor :bg
  attr_accessor :ratio
  attr_accessor :rounded

  def initialize(args)
    self.name = args[:name] || 'John Doe'
    self.size = [[args[:size].to_i, 512].min, 16].max
    self.color = args[:color]
    self.bg = args[:bg]
    self.ratio = [[args[:ratio].to_i, 80].min, 20].max
    self.rounded = args[:rounded].to_s.casecmp('true') == 0
  end

  def initials
    name.split.first(2).map(&:first).join.upcase
  end

  def background
    return "##{Digest::MD5.hexdigest(name)[0, 6]}" if bg.blank?
    bg
  end

  def cache_key
    Digest::MD5.hexdigest("#{initials}#{size}#{color}#{background}#{ratio}#{rounded}")
  end

  def file_path
    File.join Rails.root, 'public', 'avatars', "#{cache_key}.png"
  end

  def save
    IMGKit.new(html,
            width: size,
            height: size,
            transparent:true,
            quality: 15)
          .to_file(file_path)
  end

  def html
    "<div style='
      position: absolute;
      top: 0;
      left: 0;
      text-align: center;
      background: #{background};
      width: #{size}px;
      height: #{size}px;
      line-height: #{size}px;
      font-family: Verdana;
      color: #{color};
      font-size: #{ratio * size / 100}px;
      border-radius: #{rounded ? '50%' : '0'};
    '>
      #{initials}
    </div>"
  end
end