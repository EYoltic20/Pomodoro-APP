//
//  pomodoroApp.swift
//  pomodoro
//
//  Created by Emilio Y Martinez on 21/09/22.
//

import SwiftUI

@main
struct pomodoroApp: App {
    @StateObject var pomodoroModel : PomodoroModel = .init()
    var body : some Scene{
        WindowGroup{
        ContentView()
            .environmentObject(pomodoroModel)
        }
    }
}
