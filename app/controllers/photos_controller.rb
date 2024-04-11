require 'tencentcloud-sdk-common'
require 'tencentcloud-sdk-Ocr'

include TencentCloud::Common
include TencentCloud::Ocr::V20181119
class PhotosController < ApplicationController
  def new

  end

  def create
    uploaded_io = params[:picture]
    if (uploaded_io)

      image_content = uploaded_io.read

      # 将图片内容转换为Base64编码
      encoded_image = Base64.strict_encode64(image_content)
      begin
        # 为了保护密钥安全，建议将密钥设置在环境变量中或者配置文件中。
        # 硬编码密钥到代码中有可能随代码泄露而暴露，有安全隐患，并不推荐。
        # cred = Credential.new('SecretId', 'SecretKey')
        cred = Credential.new(ENV["SecretId"] , ENV["SecretKey"])
        cli = Client.new(cred, 'ap-guangzhou')

        # client = TencentCloud::Ocr::V20181119::Client.new(
        #   credential: TencentCloud::Common::Credential.new(ENV["SecretId"], ENV["SecretKey"]),
        #   region: 'ap-guangzhou'
        # )
        resq=AdvertiseOCRRequest.new(encoded_image,nil)  # Example: call the `GeneralBasicOCR` API
        response = cli.GeneralBasicOCR(resq)
         response.TextDetections.each do |context|
           puts context.DetectedText
         end
        # req = DescribeInstancesRequest.new(nil, nil, 0, 1)
        # cli.DescribeInstances(req)
      rescue TencentCloudSDKException => e
        puts e.message
        puts e.backtrace.inspect
      end

    else
      puts "!!!!!!!!!!!"
    end

  end

  def show

    # redirect_to action: "show"
  end
end
