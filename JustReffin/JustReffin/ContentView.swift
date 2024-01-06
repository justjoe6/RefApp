//
//  ContentView.swift
//  JustReffin
//
//  Created by Joseph Ranieri on 11/12/23.
//

import SwiftUI

struct ContentView: View {

    @State var team1:String = ""
    @State var team2:String = ""
    @State var homeColor:String = "Black"
    @State var awayColor:String = "Black"
    @State var homeScore = 0
    @State var awayScore = 0
    
    
    var body: some View {
        
        ZStack{
            Color(.white).ignoresSafeArea()
            VStack{
                Spacer()
                Spacer()
                
                HStack {
                    VStack {
                        Text("Home")
                        if(homeColor == "Black")
                        {
                            Circle().foregroundColor(.black)
                        }
                        else if(homeColor == "Red")
                        {
                            Circle().foregroundColor(.red)
                        }
                        else if(homeColor == "Blue")
                        {
                            Circle().foregroundColor(.blue)
                        }
                        else if(homeColor == "Green")
                        {
                            Circle().foregroundColor(.green)
                        }
                        Picker(selection: $homeColor, label: Text("Picker")) {
                            Text("Black").tag("Black")
                            Text("Blue").tag("Blue")
                            Text("Red").tag("Red")
                            Text("Green").tag("Green")
                        }
                        TextField("Name", text: $team1)
                            .border(Color.black)
                        Stepper(value: $homeScore, in: 0...99) {
                            
                        }.padding(.trailing, 8.0)
                    }.padding(.horizontal).fixedSize()
                    
                    VStack{
                        Text("\(homeScore) - \(awayScore)").font(.system(size:36))
                    }.frame(width: 100.0, height: 50.0)
                    
                    VStack {
                        Text("Away")
                        if(awayColor == "Black")
                        {
                            Circle().foregroundColor(.black)
                        }
                        else if(awayColor == "Red")
                        {
                            Circle().foregroundColor(.red)
                        }
                        else if(awayColor == "Blue")
                        {
                            Circle().foregroundColor(.blue)
                        }
                        else if(awayColor == "Green")
                        {
                            Circle().foregroundColor(.green)
                        }
                        Picker(selection: $awayColor, label: Text("Picker")) {
                            Text("Black").tag("Black")
                            Text("Blue").tag("Blue")
                            Text("Red").tag("Red")
                            Text("Green").tag("Green")
                        }
                        TextField("Name", text: $team2)
                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                        Stepper(value: $awayScore, in: 0...99) {
                            
                        }.padding(.trailing, 8.0)
                    }.padding(.horizontal).fixedSize()
                    
                }
                Spacer()
                HStack {
                    
                    Button("Submit") {
                        let gameObject = Game(homeTeam: team1, awayTeam: team2, homeScore:homeScore,awayScore:awayScore)
                        
                        var savedGames:[Game]=[]
                        
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
                        
                        do{
                            let encoder = JSONEncoder()
                            savedGames.append(gameObject)
                            let data =  try encoder.encode(savedGames)
                            UserDefaults.standard.set(data, forKey: "Game")

                        }
                        catch
                        {
                            print("Can't Encode")
                        }
                        
                        
                        team1=""
                        team2=""
                        homeScore=0
                        awayScore=0
                        homeColor = "Black"
                        awayColor = "Black"
                        
                    }
                }
                Spacer()
                Spacer()
                
            }
        }
    }
}

#Preview {
    ContentView()
}
