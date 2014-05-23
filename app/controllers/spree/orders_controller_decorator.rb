Spree::OrdersController.class_eval do
    def edit
      @deliveries = Delivery.all
      @order = current_order || Order.new
      associate_user
      if stale?(current_order)
        respond_with(current_order)
      end
    end
    def add_delivery
    	@delivery = Delivery.new
    	@delivery.description = params[:del_dsc]
    	@delivery.save
    	redirect_to :action => :edit
    end
end