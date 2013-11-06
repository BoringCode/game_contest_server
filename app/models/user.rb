class User < ActiveRecord::Base
   has_many :referees
   has_many :players
   has_many :contests
   has_secure_password
   
   validates(:username, presence: true, uniqueness: true, length: {maximum: 20})
   validates(:password, presence: true)
   validates(:email, presence: true, format: /(\w+)@([a-zA-Z]+)(\.)([a-zA-Z])/i)
end