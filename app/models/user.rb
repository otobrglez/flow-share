class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :flow_accesses, foreign_key: :user_id
  has_many :flows, through: :flow_accesses

  has_many :owned_flows, foreign_key: :creator_id, dependent: :destroy, class_name: "Flow"

  validates :username, uniqueness: true, presence: true, length: { minimum: 3, maximum: 25 }
  validates :username, format: { with: /\A[\w-]+\Z/, message: "can only be alphanumeric with no spaces" }

  def to_s
    username
  end

end
