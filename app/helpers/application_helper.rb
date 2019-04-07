module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = 'SampleApp'
    page_title.empty? ? base_title : "#{page_title.titlecase} | #{base_title}"
  end
end
