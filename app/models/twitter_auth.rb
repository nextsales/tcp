class TwitterAuth < ActiveRecord::Base
  attr_accessible :description, :favourites_count, :followers_count, :friends_count, :id_str, :image, :lang, :listed_count, :location, :name, :nickname, :origin_created_at, :provider, :secret, :time_zone, :token, :uid, :user_id
  belongs_to :user
end
