class UsersController < ApplicationController
  # Exige que o usuário esteja logado
  before_action :authenticate_user!
  respond_to :json

  devise :database_authenticatable, :registerable, :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist
  def index
    @users = User.all
    render json: @users
  end

  # Ação de exclusão de usuário
  def desactivate
    # Desativar o usuário atual
    user = User.find(params[:id])
    if user_ update(active: false)
    # Redireciona para a página inicial com uma mensagem
    redirect_to root_path, notice: "Conta excluída com sucesso."
    end
  end
end
