class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, presence: true

  has_many :tasks
  has_one :access_token

  delegate :token, to: :access_token

  def full_name
    [first_name, last_name].join(' ')
  end
end
