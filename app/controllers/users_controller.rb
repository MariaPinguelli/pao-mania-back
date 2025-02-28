class UsersController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]
  # Exige que o usuário esteja logado
  respond_to :json

  devise :database_authenticatable, :registerable, :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist
  def index
    @users = User.all
    render json: @users
  end

  # Ação para listar usuários
  def index
    users = User.all
    render json: users
  end

  # Ação para desativar o usuário
  def deactivate
    user = User.find(params[:id])

    if user.update(active: false)
      render json: { message: "Conta desativada com sucesso." }, status: :ok
    else
      render json: { error: "Não foi possível desativar a conta." }, status: :unprocessable_entity
    end
  end
end
