class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  # Lista todos os produtos
  def index
    @products = Product.all
    render json: @products
  end

  # Exibe um produto específico
  def show
  end

  # Formulário para criar um novo produto
  def new
    @product = Product.new
  end

  # Cria um novo produto
  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: "Produto criado com sucesso."
    else
      render :new
    end
  end

  # Formulário para editar um produto existente
  def edit
  end

  # Atualiza um produto existente
  def update
    if @product.update(product_params)
      render json: @product, status: :ok
    else
      render json: @product, status: 500
    end
  end

  # Exclui um produto
  def destroy
    @product.destroy
    head :no_content
  end

  private

  # Encontra o produto pelo ID
  def set_product
    @product = Product.find(params[:id])
  end

  # Permite apenas os parâmetros seguros para criação e atualização
  def product_params
    params.require(:product).permit(:name, :description, :price)
  end
end
