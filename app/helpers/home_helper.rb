module HomeHelper

  def option_tag value, content
    raw("<option value='#{value}'>#{content}</option>")
  end
end
