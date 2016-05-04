class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :entries

  scope :recent, -> { order(updated_at: :desc).limit(10) }

  validates :name, presence: true, length: { maximum: 255 }

  before_validation :generate_name, on: :create

  def to_param
    name
  end

  private

  def generate_name
    self.name ||= email.sub(/@.*/, '')
  end
end
