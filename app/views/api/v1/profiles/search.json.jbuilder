json.search_result @players  do |player|
    json.username player.username
    json.platform player.platform
    json.avatar_url player.avatar_url
end