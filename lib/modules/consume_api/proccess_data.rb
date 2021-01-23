class ConsumeApi::ProccessData
    
    def self.start (data = {})
        # Notes
        # - data [ player 'platformInfo', legend 'platformInfo', game, member, segemnts]
        # - Find or create Game []
        game = set_game('Apex Legends')
        # Game.find_or_create_by(title: 'Apex Legends')
        # - Find or create Player []
        plt_username = data['data']['platformInfo']['platformUserId']
        plt_plaform_name = data['data']['platformInfo']['platformSlug']
        player = set_player(plt_username,plt_plaform_name)
        # Player.find_or_create_by(username: data['data']['platformInfo']['platformUserId'])
        # player.update_attributes!(platform: data['data']['platformInfo']['platformSlug'])
        # - Find or create Member [player, game]
        member = Member.find_or_create_by(game_id: game.id, player_id: player.id, identifier: "#{player.id.to_s}|#{game.id.to_s}")

        legend = {}
        segments = []

        data['data']['segments'].each do |segment|
            if segment['type'] == "legend"
                # find legend
                legend = Legend.find_or_create_by(game_id: game.id, name: segment['metadata']['name'])
                segments << {
                    legendDisplayName: legend.name,
                    stats: stats(segment,legend.id,player.id)
                }
                # legend = Legend.find_or_create_by(game_id: game.id, player_id: player.id, name: segment['metadata']['name'])
            end
        end

        

        return {
            game: set_game('Apex Legends'),
            player: player,
            member: member,
            segments: segments,
            legend: legend
        }

    end

    def self.set_game (title)
        Game.find_or_create_by(title: title)
    end

    def self.set_player(username,platformSlug)
        player = Player.find_or_create_by(username: username)
        player.update_attributes!(platform: platformSlug)
        return player
    end

    def self.set_legend(game,name)
        Legend.find_or_create_by(game_id: game.id, name: name)
    end
    
    def self.set_membership(game,player,identifier) #  identifier: "#{player.id.to_s}|#{game.id.to_s}"
        Member.find_or_create_by(game_id: game.id, player_id: player.id, identifier: identifier)
    end

    def self.set_stat
        # stat = Stat.find_or_create_by(player_id: player.id, legend_id: legend.id, identifier: )
    end

    def self.stats(stats,legend,player)
        new_stats = {}
        stats['stats'].each do |stat|
            stat = Stat.find_or_create_by(
                player_id: player, legend_id: legend, identifier: "#{stat[1]['displayName']}|#{player}|#{legend}")
            new_stats = {
                rank: stat[1]['rank'],
                percentile: stat[1]['percentile'],
                displayName: stat[1]['displayName'],
                displayCategory: stat[1]['displayCategory'],
                category: stat[1]['category'],
                metadata: stat[1]['metadata'],
                value: stat[1]['value'],
                displayValue: stat[1]['displayValue'],
                displayType: stat[1]['displayType'],
                identifier: stat[1]['identifier']
            }
        end
        
        return new_stats
    end
end