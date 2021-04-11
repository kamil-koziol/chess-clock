//
//  ContentView.swift
//  Chess Clock
//
//  Created by Kamil Kozioł on 05/04/2021.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State var player1: Player = Player();
    @State var player2: Player = Player();
    
    @State var playerTurn = 0;
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common)
    @State private var timerSubscription: Cancellable?
    
    @State var showSettingsView: Bool = false;
    
    
    var settings: Settings = Settings()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Button(action: {
                        
                        if(playerTurn == 0) {
                            playerTurn = 2
                            restartTimer()
                        }
                        
                        if(playerTurn == 1) {
                            restartTimer()
                            player1.onTurnEnd()
                            playerTurn = 2;
                        }
                    }, label: {
                        ClockView(counter: $player1.timeRemaining)
                            .background(playerTurn == 1 ? Color.accentColor: Color.white)
                            .foregroundColor(playerTurn == 1 ? Color.white: Color.accentColor)
                    })
                    .rotationEffect(.radians(.pi))
                    
                    Button(action: {
                        
                        if(playerTurn == 0) {
                            playerTurn = 2
                            restartTimer()
                        }
                        
                        if(playerTurn == 2) {
                            restartTimer()
                            player2.onTurnEnd();
                            playerTurn = 1
                        }
                    }, label: {
                        ClockView(counter: $player2.timeRemaining)
                            .background(playerTurn == 2 ? Color.accentColor: Color.white)
                            .foregroundColor(playerTurn == 2 ? Color.white: Color.accentColor)
                    })
                }
                
                HStack {
                    Spacer()
                    
                    // Restart Button
                    Button(action: {
                        syncPlayersWithSettings()
                        stopTimer()
                    }, label: {
                        Image(systemName: "memories")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    })
                    Spacer()
                    
                    // Play-Pause Button
                    Button(action: {
                        if(timerSubscription == nil) {
                            startTimer()
                        } else {
                            stopTimer()
                        }
                    }, label: {
                        Image(systemName: timerSubscription == nil ? "play.fill": "pause.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    })
                    Spacer()
                    
                    // Settings
                    Button(action: {
                        stopTimer()
                        self.showSettingsView.toggle();
                    }, label: {
                        Image(systemName: "gearshape.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }).sheet(isPresented: $showSettingsView, onDismiss: {
                        syncPlayersWithSettings()
                    }, content: {SettingsView()})
                    Spacer()
                }
                .padding()
                .background(Color.init(white: 0.15))
            }
            
            .edgesIgnoringSafeArea(.all)
        }
        .edgesIgnoringSafeArea(.all)
        .onReceive(timer, perform: { _ in
            onTimerTick()
        })
        .statusBar(hidden: true)
        .environmentObject(settings)
        .onAppear(perform: {
            syncPlayersWithSettings()
        })
        
    }
    
    func syncPlayersWithSettings() {
        player1 = Player(timeRemaining: settings.counter, increment: settings.increment)
        player2 = Player(timeRemaining: settings.counter, increment: settings.increment)
    }
    
    func startTimer() {
        if self.timerSubscription == nil {
            self.timer = Timer.publish(every: 1, on: .main, in: .common)
            self.timerSubscription = self.timer.connect()
        }
    }
    
    func stopTimer() {
        timerSubscription?.cancel()
        timerSubscription = nil
    }
    
    func restartTimer() {
        stopTimer()
        startTimer()
    }
    
    func onTimerTick() {
        if(playerTurn == 1) {
            player1.decreaseTime(amount: 1)
        } else {
            player2.decreaseTime(amount: 1)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
