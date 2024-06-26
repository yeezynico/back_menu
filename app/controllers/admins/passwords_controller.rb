class Admins::PasswordsController < Devise::PasswordsController
  respond_to :json

  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    if successfully_sent?(resource)
      @admin = resource
      render json: { message: 'Un email de réinitialisation de mot de passe a été envoyé.' }, status: :ok
    else
      render json: { error: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  protected

  def resource_params
    params.require(:admin).permit(:email)
  end
end
