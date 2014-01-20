class FlowMailer < ActionMailer::Base
  default from: ENV["MAIL_SENDER"]

  def access_created flow_access
    @flow_access ||= flow_access

    mail to: @flow_access.user.email,
      subject: "#{@flow_access.flow} - FlowShare"
  end

  def access_destroyed flow_access
    @flow_access ||= flow_access

    mail to: @flow_access.user.email,
      subject: "#{@flow_access.flow} - FlowShare"
  end
end
