class Admins::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      AdminMailer.welcome_email(resource).deliver_now
      register_success
    else
      register_failed
    end
  end

  def register_success
    render json: {
      message: 'Signed up successfully.',
      admin: current_admin,
      token: request.env['warden-jwt_auth.token'] # Retourne le token
    }, status: :ok
  end

  def register_failed
    render json: { message: 'Something went wrong.' }, status: :unprocessable_entity
  end
end
