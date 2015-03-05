# == Schema Information
#
# Table name: taggings
#
#  id           :integer          not null, primary key
#  tag_topic_id :integer
#  surl_id      :integer
#

class Tagging < ActiveRecord::Base
  belongs_to :tag_topic,
             foreign_key: :tag_topic_id,
             primary_key: :id,
             class_name: :TagTopic
  belongs_to :url,
             foreign_key: :surl_id,
             primary_key: :id,
             class_name: :ShortenedUrl
end
