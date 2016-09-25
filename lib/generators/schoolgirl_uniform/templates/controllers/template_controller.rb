class <%= class_name %>Controller < SchoolgirlUniform::BaseController
    
    def initialize_form
      @form = <%= class_name.camelcase %>Form.new(session[session_key] || {})
      # @form.user_id = current_user.id
    end
    
    def session_key
      :#{controller_name.underscore}
    end
    
    attr_reader :<%= plural_name %>, :<%= plural_name.singularize %>
end
