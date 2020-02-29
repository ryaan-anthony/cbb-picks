module DictionaryHelper
  def follow_text(record)
    record.favorite? ? 'Unfollow' : 'Follow'
  end

  def refresh_text
    'Refresh'
  end

  def update_text
    'Update'
  end
end