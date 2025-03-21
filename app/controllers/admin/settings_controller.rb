class Admin::SettingsController < Admin::BaseController
  before_action :authenticate_admin!
  before_action :set_setting

  def edit
  end

  def update
    if @setting.update(setting_params)
      redirect_to admin_root_path, notice: "Settings updated successfully."
    else
      render :edit
    end
  end

  private

  def set_setting
    @setting = Setting.instance
  end

  def setting_params
    params.require(:setting).permit(:remind_after_quantity, :remind_after_unit, :reminder_email_text)
  end
end
