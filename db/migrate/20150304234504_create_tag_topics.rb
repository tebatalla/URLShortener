class CreateTagTopics < ActiveRecord::Migration
  def change
    create_table :tag_topics do |t|
      t.string :topic
      t.timestamps
    end

    create_table :taggings do |t|
      t.integer :tag_topic_id
      t.integer :surl_id
    end

    add_index(:taggings, :surl_id)
  end
end
