# frozen_string_literal: true

class Api::V1::UploadController < ApplicationController
  def upload
    url = Aws::Upload.new(file_name, dir).execute

    render json: { img_url: url }
  end

  def file_name
    params[:image].original_filename
  end

  def dir
    params[:image].tempfile.path
  end
end
