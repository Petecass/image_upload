# Skips post processing of images in specs to increase speed
module Paperclip
  def self.run(cmd, arguments = '', interpolation_values = {}, local_options = {})
    cmd == 'convert' ? nil : super
  end
end

class Paperclip::Attachment
  def post_process; end
end
