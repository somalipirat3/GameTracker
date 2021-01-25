class ConsumeApi::SaveData
    def initialize(data)
        @data = data
        @game = game
        @player = player
        @membership = set_membership
        @saved_stats = 0
        @stats = stats

    end

    def game
       game = Game.find_or_create_by(title: 'Apex Legends')
       return {
           id: game.id,
           title: game.title,
           release_date: game.release_date,
           summary: game.summary
       }
    end

    def player
        username = @data[:player]['platformUserId'].to_s
        platform = @data[:player]['platformSlug'].to_s
        avatar = @data[:player]['avatarUrl'].to_s
        # .update_attributes!()
        player = Player.find_or_create_by(username: username, platform: platform, avatar_url: avatar)
    end

    def set_membership
        # Member.find_or_create_by(game_id: game[:id], player_id: player.id)
    end

    def stats

        @data[:stats].each do |stat|
            @saved_stats = @saved_stats +1
            legend = find_legend(stat[:legendName])
            stat[:stat].each do |s|

                stat = Stat.find_or_create_by(player_id: player.id, legend_id: legend.id, displayName: s[:displayName].to_s)
                .update_attributes!(
                    rank: s[:rank].to_s,
                    percentile: s[:percentile].to_s,
                    displayCategory: s[:displayCategory].to_s,
                    category: s[:category],
                    metadata: s[:metadata],
                    value: s[:value],
                    displayValue: s[:displayValue],
                    displayType: s[:displayType]
                )

            end
            
            
            
        end

        # 
    end

    private

    def find_legend name = ""
        Legend.find_or_create_by(game_id: game[:id], name: name)
    end

    
end