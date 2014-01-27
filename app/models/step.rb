class Step < ActiveRecord::Base
  include Nameable
  include RankedModel
  include Attachable
  include ActiveModel::Dirty

  belongs_to :flow
  belongs_to :assignee, class_name: User
  belongs_to :achiever, class_name: User

  ranks :row_order, with_same: :flow_id

  validates :name, presence: true

  around_update :handle_achived

  attr_writer :mailer
  def mailer; @mailer ||= StepMailer; end

  def handle_achived
    achiever_id_changed = self.achiever_id_changed?
    yield
    notify_about_achieved if achiever_id_changed
  end

  def notify_about_achieved
    mailer.notify_about_achieved(self)
  end

  def completed?
    self.achiever.present? or self.achiever_id.present?
  end

  attr_accessor :can_do
  def can_do?
    self.can_do || false
  end

end
