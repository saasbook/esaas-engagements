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

  def menu_field(model, field_name, printable_name: 'name', model_class: nil)
    model_class ||= field_name.to_s.capitalize.constantize
    foreign_key = "#{field_name}_id"
    content_tag('div', :class => 'field') do
      [model.label(field_name), '<br/>',
        select(model.object_name, foreign_key,
          options_from_collection_for_select(model_class.send(:all),
              'id', printable_name, model.object.send(foreign_key)))].
          map(&:html_safe).
          join("\n").html_safe
    end
  end

  def form_errors_for(object=nil)
    render 'shared/form_errors', object: object unless object.blank?
  end

end
