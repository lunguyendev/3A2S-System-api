# frozen_string_literal: true

class Aws::Upload
  def initialize(file_name, file_path)
    @file_name = "#{DateTime.now.to_i}-#{file_name}"
    @file_path = file_path
  end

  def execute
    object = client.bucket(ENV["BUCKET_NAME"]).object(file_name)
    result = object.upload_file(file_path)
    return object.public_url if result

    raise Errors::ExceptionHandler::ExecuteFail, I18n.t("errors.execute_fail")
  end

  private
    attr_reader :file_name, :file_path

    def client
      Aws::S3::Resource.new(
        credentials: Aws::Credentials.new(
          ENV["AWS_KEY"],
          ENV["AWS_SECRET"]
        ),
        region: "ap-southeast-1")
    end
end
