class User < ActiveRecord::Base
   require 'carrierwave'
    mount_uploader :avatar, AvatarUploader
    has_secure_password
     has_many :testimonies, dependent: :delete_all
     has_many :comments, dependent: :delete_all


    def self.confirm(params)
        @user = User.find_by(email: params[:email])
        @user.try(:authenticate, params[:password])
    end

    validates :first_name, :last_name, :email,
              presence: true,
              length: { maximum: 255 }, on: :create

    validates :email,
              uniqueness: true,
              format: {
                  with: /(.+)@(.+)/,
                  message: 'not a valid format'
              }, on: :create
end
