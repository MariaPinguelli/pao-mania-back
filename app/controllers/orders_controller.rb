class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def create
    @order = current_user.orders.new(status: "pendente")

    # Adiciona os itens do pedido (produto + quantidade)
    params[:order][:products].each do |product_id, quantity|
      product = Product.find(product_id)
      @order.order_items.build(product: product, quantity: quantity, price: product.price)
    end

    if @order.save
      redirect_to @order, notice: "Pedido criado com sucesso!"
    else
      render :new
    end
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def update
    @order = current_user.orders.find(params[:id])
    if @order.update(order_params)
      redirect_to @order, notice: "Pedido atualizado!"
    else
      render :edit
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
