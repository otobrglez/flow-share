class StepMailer < ActionMailer::Base
  include SendGrid

  default from: ENV["MAIL_SENDER"]

  def self.notify_about_achieved step
    @achiever = step.achiever
    @users = [step.flow.creator, step.flow.users].flatten.uniq

    @users.delete @achiever

    @users.each do |user|
      achieved(step, user, @achiever).deliver
    end
  end

  def achieved step, user, achiever
    sendgrid_category "achieved_report"

    @step ||= step
    @flow = @step.flow
    @user ||= user
    @achiever = achiever

    mail to: user.email,
      subject: "Step completed - #{@flow} - FlowShare"
  end

end
