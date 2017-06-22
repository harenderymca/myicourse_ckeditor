class Ckeditor::ApplicationController < Ckeditor.parent_controller.constantize
  layout Ckeditor.controller_layout

  before_action :find_asset, only: [:destroy]
  before_action :ckeditor_authorize!
  before_action :authorize_resource

  protected

  def respond_with_asset(asset,college)
    
    asset_response = Ckeditor::AssetResponse.new(asset, request)
    @attachment.assetable_type = college.name unless college.blank? rescue nil
    @attachment.assetable_id = session[:course_in_use] unless @attachment.blank?
    begin
      if asset.save
        render asset_response.success(config.relative_url_root)
      else
        render asset_response.errors
      end
    rescue
      render asset_response.success(config.relative_url_root)
    end
  end
end
