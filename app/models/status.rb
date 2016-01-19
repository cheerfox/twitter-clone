class Status < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  validates :creator, presence: true
  validates :body, presence: true, length: { minimum: 5 }

  after_save :extract_mentions



  def extract_mentions
    mentions = self.body.scan(/@(\w*)/).flatten
    mentions.each do |mention|
      user = User.find_by username: mention
      if user
        Mention.create(user_id: user.id, status_id: self.id)
      end
    end    
  end

  def self.get_status_of_hashtag(hashtag)
    where("body LIKE '%##{hashtag}%'")
  end

end