class Spree::Admin::ClientAccountsController < Spree::Admin::BaseController
  before_action :set_client_account, only: [:show, :edit, :update, :destroy]

  # GET /client_accounts
  def index
    @client_accounts = Spree::ClientAccount.all
  end

  # GET /client_accounts/1
  def show
  end

  # GET /client_accounts/new
  def new
    @client_account = Spree::ClientAccount.new
  end

  # GET /client_accounts/1/edit
  def edit
  end

  # POST /client_accounts
  def create
    @client_account = Spree::ClientAccount.new(client_account_params)

    if @client_account.save
      redirect_to [:admin, @client_account], notice: 'Client account was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /client_accounts/1
  def update
    if @client_account.update(client_account_params)
      redirect_to [:admin, @client_account], notice: 'Client account was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /client_accounts/1
  def destroy
    @client_account.destroy
    redirect_to admin_client_accounts_url, notice: 'Client account was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_account
      @client_account = Spree::ClientAccount.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def client_account_params
      params.require(:client_account).permit(:name, :credit_duration, :credit_limit)
    end
end
