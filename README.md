
Follow is code
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


