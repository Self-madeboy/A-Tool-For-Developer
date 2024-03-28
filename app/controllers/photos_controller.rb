class PhotosController < ApplicationController
  def new

  end

  def create
    uploaded_io = params[:picture]
    if (uploaded_io)

      image_content = uploaded_io.read

      # 将图片内容转换为Base64编码
      encoded_image = Base64.strict_encode64(image_content)
      puts encoded_image

    else
      puts "!!!!!!!!!!!"
    end

  end

  def show

    # redirect_to action: "show"
  end
end
