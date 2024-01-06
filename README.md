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

The ContentView file allows for keeping track of a current game and one of the features it provides is it allows the user to select the color a team is wearing and display that color below home and away in the form of a circle. It does this through a picker which is located just below the circle.

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
