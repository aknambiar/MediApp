module SvgHelper
  def show_svg(path)
    File.open("app/assets/images/#{path}", "rb") do |file|
      raw file.read
    end
  end

  def show_resized_svg(path, height=nil, width=nil)
    svg = show_svg(path)
    svg.sub!(/height="[0-9]+"/, "height=\"#{height}\"") if height
    svg.sub!(/width="[0-9]+"/, "width=\"#{width}\"") if width
    raw svg
  end
end
