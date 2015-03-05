# == Schema Information
#
# Table name: tag_topics
#
#  id         :integer          not null, primary key
#  topic      :string
#  created_at :datetime
#  updated_at :datetime
#

class TagTopic < ActiveRecord::Base

  TOPICS = %w(news sports tech fashion music)

  has_many :taggings,
           foreign_key: :tag_topic_id,
           primary_key: :id,
           class_name: :Tagging
  has_many :urls,
           through: :taggings,
           source: :url
  has_many :visits,
    through: :urls,
    source: :visits

  validates :topic,
    inclusion: {
                 in: TOPICS,
                 message: "Topic is not in the approved list of topics"
               }

  def most_popular_links(n)
    ShortenedUrl.joins(:visits).joins(:taggings).
      where("taggings.tag_topic_id = ?", self.id).group("visits.surl_id").
        order("COUNT(visits.surl_id) DESC").limit(n)
  end

end
