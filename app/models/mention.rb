class Mention < ActiveRecord::Base
  belongs_to :user
  belongs_to :status

  def mark_viewed!
    self.update(viewed_at: DateTime.now)
  end
end