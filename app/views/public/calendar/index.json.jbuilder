json.array!(@posts) do |post|
  json.id post.id
  json.title post.task.name
  json.start post.start.in_time_zone('Tokyo')
  json.end post.end.in_time_zone('Tokyo')
  json.url "/users/calendar_posts?date=#{post.start.strftime("%Y-%m-%d")}"
end