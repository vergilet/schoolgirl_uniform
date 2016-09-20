module SchoolgirlUniform
  class BaseController < ActionController::Base

    # before_action :authenticate_user!
    before_action :reset_session, only: :show
    before_action :refresh_session, only: [:next, :create]
    before_action :initialize_form,  except: [:index]
    after_action :refresh_current_step, only: [:next, :previous]

    def show; end

    def finish; end

    def initialize_form
      @form = BaseForm.new(session[session_key] || {})
      @form.user_id = current_user.id
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
      render 'show'
    end

    def create
      if @form.valid?
        @form.save!
        render :finish, locals: {form: @setup_form }
        reset_session
      else
        render 'show'
      end
    end

    def form_carrier
      @form_carrier ||= SchoolgirlUniform::Carriers::Carrier.new(@form)
    end

    private

    def refresh_current_step
      session[session_key][:step] = @form.current_step
    end

    def metadata_params
      #params.permit(:key)
    end

    def session_params
      session_params = metadata_params[session_key].deep_dup
      session_params.deep_merge({
                                    "#{metadata_params[session_key][:step]}_attributes" => metadata_params.except(session_key).to_hash
                                })
    end

    def session_key
      session_key
    end
  end
end
