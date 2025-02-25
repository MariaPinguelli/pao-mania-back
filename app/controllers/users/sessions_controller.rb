class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    self.resource = warden.authenticate!(scope: :user)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)

    # Gere o token JWT
    token = JWT.encode({ user_id: resource.id }, Rails.application.secret_key_base, "HS256")

    render json: { message: "Login bem-sucedido", user: resource, token: token }, status: :ok
  end
end
