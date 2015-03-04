class Visit < ActiveRecord::Base
  def self.record_visit!(user, shortened_url)
    Visit.create!(visitor: user, surl: shortened_url)
  end

  belongs_to :visitor,
             foreign_key: :visitor_id,
             primary_key: :id,
             class_name: :User

  belongs_to :surl,
             foreign_key: :surl_id,
             primary_key: :id,
             class_name: :ShortenedUrl

end
