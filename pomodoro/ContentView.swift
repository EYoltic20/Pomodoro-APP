//
//  ContentView.swift
//  pomodoro
//
//  Created by Emilio Y Martinez on 21/09/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var pomodoroModel : PomodoroModel
    var body: some View {
        Home()
            .environmentObject(pomodoroModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
