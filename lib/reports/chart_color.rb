class ChartColor
  COLORS = [  "#ED7B00","#DE000F","#992B00", "#005CDE", "#00A36A", "#7D0096"]
  cur_color_position = -1

  define_method :initialize do
    cur_color_position = -1
  end

  define_method :next_color do
    COLORS[increment_color_position]
  end
  
  private
  
  define_method :increment_color_position do
    cur_color_position = cur_color_position >= COLORS.length-1 ? 0 : cur_color_position += 1;
    return cur_color_position
  end
  
end


  
