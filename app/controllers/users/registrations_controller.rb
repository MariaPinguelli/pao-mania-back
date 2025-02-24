class Users::RegistrationsController < Devise::RegistrationsController
  # Sobrescreve o método create do Devise para adicionar lógica ao cadastro
  def create
    super do |resource|
      # Verifica se esse é o primeiro usuário
      if User.count == 1
        resource.update(admin: true)
      end
    end
  end
end
