//
//  PomodoroModel.swift
//  pomodoro
//
//  Created by Emilio Y Martinez on 21/09/22.
//

import Foundation
import SwiftUI
class PomodoroModel : NSObject,ObservableObject, UNUserNotificationCenterDelegate{
//    MARK: PROPERTIES
    @Published var progress : CGFloat = 1
    @Published var timerString : String = "00:00"
    @Published var isStarted : Bool = false
    @Published var addNewTimer : Bool = false
    
    @Published var hour : Int = 0
    @Published var minute : Int = 0
    @Published var seconds : Int = 0
//    MARK: -post timer
    @Published var isFinished: Bool = false
    
//    MARK: -Total second
    @Published var totalSecond : Int = 0
    @Published var staticTotalSecond:Int = 0

//     es un nsobject
    override init(){
        super.init()
        self.authorizeNotifi()
    }
    
//    MARK: -Pedir autth para la notificacion
    func authorizeNotifi(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound,.alert,.badge]){ _ , _ in
        }
//        MARK: -show in app noti
        UNUserNotificationCenter.current().delegate = self
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound,.banner])
    }
    
    //    MARK: -START TIMER
    func startTimer(){
        withAnimation(.easeInOut(duration: 0.25)){isStarted = true}
//        MARK: -SETTING string time value
        timerString = "\(hour == 0 ? "" : "\(hour):")\(minute>=10 ? "\(minute):":"0\(minute):")\(seconds >= 10 ? "\(seconds)":"0\(seconds)")"
//        MARK: -calculating total sedocnd for timer animation
        totalSecond = (hour*3600)+(minute*60) + seconds
        staticTotalSecond = totalSecond
        addNewTimer = false
        addNotificacion(timer: staticTotalSecond)
    }
//   MARK: -Func Stop time
    func stopTime(){
        withAnimation{
            isStarted = false
            hour = 0
            minute = 0
            seconds = 0
            progress = 1
        }
        totalSecond = 0
        staticTotalSecond=0
        timerString = "00:00"
    }
//    MARK: -update timer
    func updateTimer(){
        totalSecond -= 1
//        60 minutacos * 60 segundos
        
        progress = CGFloat(totalSecond)/CGFloat(staticTotalSecond)
        progress = (progress < 0 ? 0 : progress)
        hour = totalSecond/3600
        
        minute = (totalSecond/60)%60
        seconds = (totalSecond%60)
        timerString = "\(hour == 0 ? "" : "\(hour):")\(minute>=10 ? "\(minute):":"0\(minute):")\(seconds >= 10 ? "\(seconds)":"0\(seconds)")"
        if hour == 0 && seconds == 0 && minute == 0{
            isStarted = false
            print("Finishied")
            isFinished = true
            
            
        }
    }
    
    func addNotificacion(timer:Int){
        let content = UNMutableNotificationContent()
        content.title = "Pomodoro"
        content.subtitle = "Se termino el tiempo"
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timer), repeats: false))
        
        UNUserNotificationCenter.current().add(request)
    }
}

//MARK : -Anotaciones
//@StateObject
//NSObject
//Scene
//CGFLOAT
