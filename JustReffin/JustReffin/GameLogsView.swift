//
//  GameLogsView.swift
//  JustReffin
//
//  Created by Joseph Ranieri on 12/21/23.
//

import SwiftUI

struct GameLogsView: View {
    
    @State private var savedGames:[Game]=[]
    
    
    var body: some View {
        
        VStack{
            Text("Game Logs")
                .bold()
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .padding(.top)
            

            
            List(savedGames, id: \.date) { game in
                HStack {
                    Spacer()
                    VStack {
                        Text("\(game.homeTeam)  \(game.homeScore) - \(game.awayScore)  \(game.awayTeam)")
                        Text("\(Calendar.current.component(.month, from: game.date))/\(Calendar.current.component(.day, from: game.date))")
                            .font(.system(size: 10))
                    }
                    Spacer()
                    Text("Delete")
                        .foregroundStyle(.blue)
                        .onTapGesture {
                            if let index = savedGames.firstIndex(where: { $0.date == game.date }) {
                                savedGames.remove(at: index)
                                do {
                                    let encoder = JSONEncoder()
                                    let data = try encoder.encode(savedGames)
                                    UserDefaults.standard.set(data, forKey: "Game")
                                } catch {
                                    print("Can't Encode")
                                }
                            }
                        }
                        .simultaneousGesture(TapGesture())
                }
            }
            
            Button("Clear"){
                do{
                    let encoder = JSONEncoder()
                    let temp:[Game]=[]
                    let data =  try encoder.encode(temp)
                    UserDefaults.standard.set(data, forKey: "Game")
                    savedGames=[]

                }
                catch
                {
                    print("Can't Encode")
                }
                
            }.padding(.bottom,40)
            
        }
        .onAppear{
            
            if let savedData = UserDefaults.standard.data(forKey: "Game")
            {
                do {
                    let decoder = JSONDecoder()
                    
                    savedGames = try decoder.decode([Game].self, from: savedData)
                }
                catch
                {
                    print("Unable to decode")
                }
            }
        }

        
    
    }
    
    
    
    
}


#Preview {
    GameLogsView()
}
