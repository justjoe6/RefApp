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


