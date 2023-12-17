require 'csv'

class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  
  before_save :send_verification_email, if: :varified_changed?
  after_create :send_creation_mail

  def self.import_csv(file)
    CSV.foreach(file.path, headers: true) do |row|
      Student.create(name: row['name'], email: row['email'],address: row['address'], date_of_birth: row['date_of_birth'], password: row['password'])
    end
  end

  private

  def send_verification_email
    StudentMailer.verification_email(self).deliver_now if self.varified
  end

  def send_creation_mail
    StudentMailer.creation_email(self).deliver_now
  end

end
