module UsersHelper
  # Return the Gravatar for the given user.
  def gravatar_for(user, size: 80)
    g_id = Digest::MD5.hexdigest(user.email.downcase)
    g_url = "https://secure.gravatar.com/avatar/#{g_id}?s=#{size}&d=retro"
    image_tag(g_url, alt: user.name, class: 'gravatar')
  end
end
