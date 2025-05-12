module SchoolgirlUniform
  class BaseController < ActionController::Base
    before_action :reset_session, only: :show
    before_action :refresh_session, only: :current
    before_action :initialize_form
    after_action :refresh_current_step, only: [:show, :current, :previous]
    helper_method :form_carrier

    def show
      redirect_to action: :current, step: @form.current_step
    end

    def initialize_form
      @form = BaseForm.new(session[session_key] || {})
    end

    def reset_session
      session[session_key] = {}
    end

    def refresh_session
      return if request.get?
      session[session_key].deep_merge!(session_params)
    end

    def current
      if request.post?
        return render :show unless @form.valid?

        @form.save_form! if @form.last_step?
        return render :show if @form.errors.present?

        redirect_to redirect_options
      elsif request.get?
        return render :show if params[:step] == @form.current_step
        redirect_to action: :current, step: @form.current_step
      end
    end

    def previous
      @form.previous_step
      redirect_to action: :current, step: @form.current_step
    end

    def form_carrier
      @form_carrier ||= SchoolgirlUniform::Carrier.new(@form, paths)
    end

    private

    def form_attributes
      initialize_form.attributes.keys
    end

    def paths
      {
        current: nil,
        previous: nil
      }
    end

    def refresh_current_step
      session[session_key]['step'] = @form.current_step
    end

    def metadata_params
      params.require(session_key).permit(form_attributes.push(:step))
    end

    def session_params
      metadata_params.to_hash
    end

    def session_key
      "#{controller_name}_form"
    end

    def redirect_options
      if @form.last_step?
        reset_session
        { action: :finish, identifier: @form.identifier }
      else
        @form.next_step
        { action: :current, step: @form.current_step }
      end
    end
  end
end
