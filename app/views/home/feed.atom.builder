atom_feed language: 'ja-JP' do |feed|
  feed.title @title
  feed.updated @updated_at

  @entries.each do |entry|
    feed.entry(entry, url: user_entry_url(entry.user, entry)) do |feed_entry|
      feed_entry.title entry.title
      feed_entry.summary entry.headline
      feed_entry.content entry.content, type: 'html'

      # the strftime is needed to work with Google Reader.
      feed_entry.updated(entry.updated_at.strftime('%Y-%m-%dT%H:%M:%SZ'))
      feed_entry.published(entry.created_at.strftime('%Y-%m-%dT%H:%M:%SZ'))

      feed_entry.author do |author|
        author.name entry.user.nickname
      end
    end
  end
end
