class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    user = User.new(sign_up_params)

    if user.save
      render json: { message: "Usuário criado com sucesso", user: user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def sign_up_params
    params.require(:registration).permit(:name, :email, :password, :password_confirmation)
  end
end
