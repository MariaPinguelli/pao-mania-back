class Users::SessionsController < Devise::SessionsController
  # Sobrescreve o método create para personalizar o login
  def create
    # Chama o método original do Devise para autenticar o usuário
    resource = User.find_for_database_authentication(email: params[:user][:email])

    if resource && resource.valid_password?(params[:user][:password])
      # Gera o token JWT
      jwt = generate_jwt(resource)
      render json: { message: "Login realizado com sucesso", user: resource, token: jwt }, status: :ok
    else
      # Retorna erro caso as credenciais sejam inválidas
      render json: { error: "Credenciais inválidas" }, status: :unauthorized
    end
  end

  private

  # Método para gerar o token JWT
  def generate_jwt(user)
    payload = { user_id: user.id, exp: 24.hours.from_now.to_i }
    JWT.encode(payload, Rails.application.secret_key_base)
  end
end
