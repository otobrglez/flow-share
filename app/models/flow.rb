class Flow < ActiveRecord::Base
  include Nameable
  include Attachable

  belongs_to :creator, class_name: "User"

  has_many :flow_accesses, ->{ order({role: :desc, updated_at: :desc}) }, foreign_key: :flow_id, dependent: :destroy
  has_many :users, through: :flow_accesses

  has_many :steps, dependent: :destroy

  validates :name, presence: true
  validates :token, presence: true, uniqueness: true, length: { maximum: 10, minimum: 10 }

  after_initialize -> { generate_token }
  after_create ->{ create_flow_access!(creator, role: "creator") }

  attr_writer :mailer
  def mailer; @mailer ||= FlowMailer; end

  def create_flow_access! other_user, options={role: "collaborator"}
    other_user = User.find(other_user[:user_id]) unless other_user.is_a?(User)
    flow_access = flow_accesses.create!({user: other_user}.reverse_merge!(options))
    mailer.access_created(flow_access).deliver if self.creator != other_user
    flow_access
  end

  def destroy_flow_access! flow_access_id
    flow_access = flow_accesses.find(flow_access_id)
    status = flow_access.destroy
    mailer.access_destroyed(flow_access).deliver if status
    [flow_access, status]
  end

  def generate_token
    self.token ||= loop do
      random_token = Digest::SHA1.hexdigest([Time.now, rand].join)[0..9]
      break random_token unless Flow.exists?(token: random_token)
    end
  end

end
