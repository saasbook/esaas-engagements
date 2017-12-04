module ApplicationHelper

  def field(model, field_name, type = :text_field, options = {})
    "\n".html_safe <<
      content_tag('div', :class => 'field') do
        [model.label(field_name), '<br/>', model.send(type, field_name, options)].
          map(&:html_safe).
          join("\n").
          html_safe
      end.html_safe <<
        "\n"
  end

  def form_errors_for(object=nil)
    render 'shared/form_errors', object: object unless object.blank?
  end

end
