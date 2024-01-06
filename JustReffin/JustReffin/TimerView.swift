//
//  TimerView.swift
//  JustReffin
//
//  Created by Joseph Ranieri on 11/24/23.
//

import SwiftUI

struct TimerView: View {
    
    @State var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State var timerRunning = false
    @State var time = 0.0
    
    var body: some View {
        VStack{
            Text("\(String(format:"%.1f",self.time))s").font(.system(size:96))
                .bold()
                .onReceive(self.timer){ t in if timerRunning{
                    time+=0.1
                }
                    
                }
            
            HStack {
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
            }
        }
    }
}

#Preview {
    TimerView()
}
