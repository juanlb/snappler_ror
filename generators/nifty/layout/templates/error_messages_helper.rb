module ErrorMessagesHelper
  # Render error messages for the given objects. The :message and :header_message options are allowed.
  def error_messages_for(*objects)
    options = objects.extract_options!


    list_items_parsed = []
    objects.first.errors.each do |msg|
      list_items_parsed << "<h4 class='alert_error'>#{objects.first.errors[msg].first}</h4>"
    end
    return list_items_parsed.join.html_safe

  end

  module FormBuilderAdditions
    def error_messages(options = {})
      @template.error_messages_for(@object, options)
    end
  end
end

ActionView::Helpers::FormBuilder.send(:include, ErrorMessagesHelper::FormBuilderAdditions)
