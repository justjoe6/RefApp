# JustReffinApp.swift

Here in the swift app file JustReffinApp.swift I've created a tab view such that the tabs on the bottom app allow the user to change between the different swift views with the initial view on start being the ContentView file. The ContentView file is where a current game can be kept track of, while the GameLogsView file allows the user to view the results of previous games, and the TimerView file serves to keep track of time.

```
            TabView {
                ContentView()
                    .tabItem {
                        Label("Match Info", systemImage:"figure.soccer")
                    }
                TimerView()
                    .tabItem {
                        Label("Timer", systemImage: "stopwatch")
                    }
                GameLogsView()
                    .tabItem {
                        Label("Game Logs", systemImage:"list.clipboard")
                    }
            }
```

# ContentView.swift
<img width="345" alt="Screenshot 2024-01-03 at 7 29 17 PM" src="https://github.com/justjoe6/RefApp/assets/68125991/673d7a11-0ecd-4bff-be81-c1729a9444e7">

The ContentView file allows for keeping track of a current game and one of the features it provides is it allows the user to select the color a team is wearing and display that color below home and away in the form of a circle. It does this through a picker which is located just below the circle and below is the code of how this is accomplished using the home team code as an example. 

```
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
            Picker(selection: $homeColor, label: Text("Picker")){
                        Text("Black").tag("Black")
                        Text("Blue").tag("Blue")
                        Text("Red").tag("Red")
                        Text("Green").tag("Green")
            }
```

Underneath the color picker the app also provides a means of inputing the name of the home and away teams and below that there is a stepper(a minus and plus button) which allows the user to increment and decrement the score of both the home and away teams.

```
            TextField("Name", text: $team1)
            .border(Color.black)
            Stepper(value: $homeScore, in: 0...99) {
                            
            }.padding(.trailing, 8.0)
```

One of the final features that this view contains is the submit button which is used in order to store a game and then display that game and previously submitted games on the GameLogsView file. Through the use of UserDefaults the app is able to store prevous games even after the app is closed. It first decodes the JSON encoded text stored in UserDefaults under the key "Game" then we append the newly submitted game to the now decoded list. Then it encodes the list using JSON again and stores it in UserDefaults.

```
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
            
                        
```

Finally all variables are reset after the submit button is pressed

```
                        team1=""
                        team2=""
                        homeScore=0
                        awayScore=0
                        homeColor = "Black"
                        awayColor = "Black"
```

# GameLogsView.swift
<img width="345" alt="Screenshot 2024-01-03 at 7 30 50 PM" src="https://github.com/justjoe6/RefApp/assets/68125991/6f8615b3-164b-481d-81ca-7209bf494211">

The following code decodes the games saved in UserDefaults from JSON when the view is loaded in so that they can be accessed and later displayed.

```
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
```

The following code goes through the list of games displaying each one's result along with the date the game took place. It also provides a delete button for each game that way games can be deleted individually if needed.

```
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
```

A clear button is provided in the case that the user would like to erase all the games recorded. 

```
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
```

# TimerView.swift
<img width="345" alt="Screenshot 2024-01-03 at 7 29 42 PM" src="https://github.com/justjoe6/RefApp/assets/68125991/79738252-8da8-4184-8381-c4457aacfd75">

This code allows the timer to run by incrementing the timer by 0.1 seconds while the timer is running and displaying it.

```
            Text("\(String(format:"%.1f",self.time))s").font(.system(size:96))
                .bold()
                .onReceive(self.timer){ t in if timerRunning{
                    time+=0.1
                }
```

The following code is what starts the timer, once the start button is pressed it triggers the timer to publish/run ever 0.1 seconds. Since initially the timer isn't running only the start button and reset button are displayed. But, once the start button is pressed it sets the timerRunning variable to true
thus causing the start button to disappear and the stop button to appear which when pressed causes the timer to stop and the start button to reappear.

```
                if(!timerRunning)
                {
                    Button("Start") {
                        timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
                        timerRunning=true
                    }
                }
                else{
                    Button("Stop") {
                        self.timer.upstream.connect().cancel()
                        timerRunning=false
                    }
                }
                Button("Reset") {
                    time=0.0
                }
```
