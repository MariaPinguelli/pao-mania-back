class OrdersController < ApplicationController
  # before_action :authenticate_user!

  def index
    user = User.find(params[:user_id])
    @orders = Order.where(user_id: params[:user_id]).includes(order_items: :product).all
    orders_json = @orders.map do |order|
      {
        id: order.id,
        user_id: order.user_id,
        user_name: user.name,
        total_price: order.total_price.to_f,
        status: order.status,
        created_at: order.created_at,
        order_items: order.order_items.map do |item|
          {
            product_id: item.product.id,
            name: item.product.name,
            product_price: item.product.price.to_f,
            quantity: item.quantity
          }
        end
      }
    end

    render json: orders_json, status: :ok
  end

  def create
    user = User.find(params[:order][:user_id])
    @order = Order.new(user: user, status: "pendente")

    params[:order][:products].each do |product_data|
      product = Product.find(product_data[:product_id])
      @order.order_items.build(product: product, quantity: product_data[:quantity],
      price: product.price)
    end

    begin
      @order.save!
      render json: @order, status: :ok
    rescue StandardError => e
      Rails.logger.error "Erro ao salvar pedido: #{e.message}"
      render json: { error: "Erro ao salvar pedido" }, status: :internal_server_error
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
    params.require(:order).permit(:user_id, :status, :products)
  end
end
