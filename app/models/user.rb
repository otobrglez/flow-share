class User < ActiveRecord::Base
  include PgSearch

  pg_search_scope :search_name,
    :against => [:username, :full_name],
    :using => [ :tsearch ], # :dmetaphone:trigrams
    :ignoring => :accents

  # Include default devise modules. Others available _are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable


  has_many :flow_accesses, foreign_key: :user_id
  has_many :flows, -> { order("flows.updated_at DESC") }, through: :flow_accesses

  has_many :owned_flows, foreign_key: :creator_id, dependent: :destroy, class_name: "Flow"

  validates :username, uniqueness: true, presence: true, length: { minimum: 3, maximum: 25 }
  validates :username, format: { with: /\A[\w-]+\Z/, message: "Username can be only alphanumeric with no spaces" }

  def to_s
    full_name || username
  end

  def avatar_url size=48
    @avatar_url ||= "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email.downcase)}.png?s=#{size}"
  end

  def attributes
    super.reverse_merge!(avatar_url: avatar_url)
  end

end
