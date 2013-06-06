class AssetsController < ApplicationController
  before_filter :authenticate_user!
  def download
    @asset = Asset.find(params[:id])

    send_file @asset.document.path,
              :filename => @asset.document_file_name,
              :type => @asset.document_content_type,
              :disposition => 'attachment'
  end
end
