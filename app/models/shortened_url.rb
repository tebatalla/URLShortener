# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  long_url     :string(1024)
#  short_url    :string
#  submitter_id :integer
#

class ShortenedUrl < ActiveRecord::Base
  def self.random_code
    loop do
      code = SecureRandom.urlsafe_base64
      return code unless ShortenedUrl.exists?(short_url: code)
    end
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(short_url: ShortenedUrl.random_code,
                         submitter: user,
                         long_url: long_url)
  end

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    self.visitors.where("visits.updated_at > ?", 10.minutes.ago).count
  end

  belongs_to :submitter,
             foreign_key: :submitter_id,
             primary_key: :id,
             class_name: :User

  has_many :visits,
           foreign_key: :surl_id,
           primary_key: :id,
           class_name: :Visit

  has_many :visitors,
    -> { distinct },
    through: :visits,
    source: :visitor
end
