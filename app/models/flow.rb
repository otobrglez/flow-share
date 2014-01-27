class Flow < ActiveRecord::Base
  include Nameable
  include Attachable
  include Rails.application.routes.url_helpers

  belongs_to :creator, class_name: "User"

  # "flow_accesses.role" => :desc
  has_many :flow_accesses, ->{ order({updated_at: :desc}) }, foreign_key: :flow_id, dependent: :destroy
  has_many :users, through: :flow_accesses

  has_many :steps, dependent: :destroy

  scope :public, -> { where(public: 1) }

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

  def to_public_param
    @to_public_param ||= "#{token}-#{name}".parameterize
  end

  def private?
    not public?
  end

  def closed?
    not open?
  end

  def duable_steps
    if @duable_steps.nil?

      @duable_steps = self.steps.rank(:row_order)

      [nil, *@duable_steps, nil].each_cons(3) do |p, c, n|

        can_do = if (p.nil? and c.achiever_id.blank?)
          true
        elsif (not(p.nil?) and c.achiever_id.blank? and p.achiever_id.present?)
          true
        else
          false
        end

        @duable_steps[@duable_steps.index(c)].can_do = can_do
      end

      return @duable_steps
    end

    @duable_steps
  end

end
