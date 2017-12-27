module GameHelper
  # it gives the textfield to enter trail numbers
  def input(name, label, value = 0)
    content_tag(:div, id: "block-#{name}", class: 'input-block') do
      content = label_tag name, "#{label}: "
      content += text_field_tag name, value, {size: 3, maxlength: 2}
    end
  end

  #helper method which is called in view file,it displays score in view

  def score_cells
    scores = ''
    @game.frame.each{|frame| scores += "<td>#{frame[:score]}</td>" if frame}
    scores
  end

  #helper method which is called in view file,it displays frames in view

  def header_cells
    header = ''
    (1..@game.frame_number).each{|frame| header += "<td>##{frame}</td>"}
    header
  end

end
