//
//  PomodoroModel.swift
//  pomodoro
//
//  Created by Emilio Y Martinez on 21/09/22.
//

import Foundation
import SwiftUI
class PomodoroModel : NSObject,ObservableObject{
//    MARK: PROPERTIES
    @Published var progress : CGFloat = 0
    @Published var timerString : String = "11:00"
    @Published var isStarted : Bool = false
    @Published var addNewTimer : Bool = false
    @Published var hour : Int = 0
    @Published var minute : Int = 0
    @Published var seconds : Int = 0 
}

//MARK : -Anotaciones
//@StateObject
//NSObject
//Scene
//CGFLOAT
