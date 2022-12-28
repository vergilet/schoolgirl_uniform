module SchoolgirlUniform
  class BaseController < ActionController::Base
    before_action :reset_session, only: :show
    before_action :refresh_session, only: [:next, :create]
    before_action :initialize_form,  except: [:index]
    after_action :refresh_current_step, only: [:next, :previous]
    helper_method :form_carrier

    def initialize_form
      @form = BaseForm.new(session[session_key] || {})
    end

    def reset_session
      session[session_key] = {}
    end

    def refresh_session
      session[session_key].deep_merge!(session_params)
    end

    def next
      return render('show') unless @form.valid?
      @form.next_step
      redirect_to action: :current
    end

    def current
      render 'show'
    end

    def previous
      @form.previous_step
      redirect_to action: :current
    end

    def create
      if @form.valid?
        @form.save!
        render :finish, locals: {form: @form }
        reset_session
      else
        render 'show'
      end
    end

    def form_carrier
      @form_carrier ||= SchoolgirlUniform::Carrier.new(@form, paths)
    end

    private

    def paths
      {
        next: nil,
        current: nil,
        previous: nil,
        create: nil
      }
    end

    def refresh_current_step
      session[session_key]['step'] = @form.current_step
    end

    def metadata_params
      params.require(session_key).permit(form_attributes.push(:step))
    end

    def session_params
      metadata_params.to_hash.deep_dup
    end

    def session_key
      "#{controller_name}_form"
    end
  end
end
