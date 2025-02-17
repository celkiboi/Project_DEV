class Admin::AdminsController < Admin::BaseController
  def index
    @admins = Admin.page(params[:page]).per(10)
  end
end
