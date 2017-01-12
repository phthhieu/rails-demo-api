module ApiResponder
  extend ActiveSupport::Concern

  included do
    rescue_from 'ActiveRecord::RecordNotFound',
                'ActionController::RoutingError',
                with: :return_404
    rescue_from 'ActionController::ParameterMissing',
                'ActionController::UnpermittedParameters',
                'ActiveRecord::RecordInvalid',
                with: :return_422
  end

  def render_error_response(error, status)
    render json: { error: error }, status: status
  end

  def render_success(record, status = :ok)
    render json: record, status: status
  end

  private

  def error_message(default_message, object)
    object.errors ? object.errors.messages : default_message
  end

  def build_error(message)
    {
      error: message,
      params: params.except(*PARAMS_BLACKLIST)
    }
  end

  def render_error_message(message, status)
    error = build_error(message)
    render_error_response(error, status)
  end

  def log_exception(exception)
    return unless logger.present?
    logger.warn "#{exception.class}: '#{exception.message}'"\
                " thrown from: #{exception.backtrace[0..10]}"
  end

  def return_404(exception)
    log_exception(exception)
    render_error_response("Resource not found" || exception.message, 404)
  end

  RESPONSE_40X.each do |status, message|
    define_method("return_#{status}") do |exception|
      log_exception(exception)
      render_error_response(message || exception.message, status.to_s.to_i)
    end
  end

  def return_422(exception)
    log_exception(exception)
    error =
      if exception.respond_to? :record
        exception.record.errors.messages
      else
        build_error(exception.message)
      end
    render_error_response(error, 422)
  end
end
