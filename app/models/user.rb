class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :entries

  scope :recent, -> { order(:updated_at).limit(10) }

  validates :name, presence: true, length: { maximum: 255 }

  def to_param
    name
  end
end
