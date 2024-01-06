//
//  Game.swift
//  JustReffin
//
//  Created by Joseph Ranieri on 12/23/23.
//

import Foundation


struct Game: Codable {
    let homeTeam: String
    let awayTeam: String
    let homeScore: Int
    let awayScore: Int
    let date:Date

    init(homeTeam: String, awayTeam: String, homeScore:Int, awayScore:Int) {
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.homeScore = homeScore
        self.awayScore = awayScore
        self.date = Date()
    }
}
