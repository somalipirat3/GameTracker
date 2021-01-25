json.profile do
    json.username @player.username
    json.platform @player.platform
    json.avatar_url @player.avatar_url

    json.game do
        json.title @game.title
        json.release_date @game.release_date
        json.summary @game.summary
    end

    json.legends_played @set_legends
end