class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!

  def create
    # Adiciona o nome junto com email e senha
    user_params = params.require(:user).permit(:email, :password, :password_confirmation, :name)

    # Cria o usuário com os parâmetros
    user = User.new(user_params)

    if user.save
      # Se for o primeiro usuário, torna-o administrador
      user.update(admin: true) if User.count == 1
      render json: { message: "Usuário cadastrado com sucesso!", user: user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
