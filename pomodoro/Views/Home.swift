//
//  Home.swift
//  pomodoro
//
//  Created by Emilio Y Martinez on 21/09/22.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var pomodoroModel : PomodoroModel
    var body: some View {
        VStack{
            Text("Pomodoro Timer")
                .font(.title)
                .foregroundColor(Color("Letras"))
                .padding(30)
            
            GeometryReader{proxy in
                //                MARK : Timer Ring
                VStack(spacing : 15){
                    ZStack{
                        Circle()
                            .fill(.blue.opacity(0.22))
                            .padding(-30)
                        //                        MARK : Shadow
                        Circle()
                            .stroke(Color("Azul").opacity(0.3),lineWidth: 15)
                            .blur(radius: 4)
                            .padding(-2)
                        
                        Circle()
                            .trim(from: 0, to: pomodoroModel.progress)
                            .stroke(Color("Azul").opacity(0.9),lineWidth: 15)
                        //                        MARK : Making the following point
                        GeometryReader{ proxy in
                            let size = proxy.size
                            
                            Circle()
                                .fill(Color("Azul"))
                                .frame(width: 30, height: 30 )
                                .overlay(content: {
                                    Circle()
                                        .fill(.white)
                                        .padding(4)
                                })
                                .frame(width: size.width,height: size.height,alignment: .center)
                            //                            MARK : since view is Rotated thats wjy using x
                                .offset(x:size.height/2)
                                .rotationEffect(.init(degrees: pomodoroModel.progress*360))
                            
                        }
                        Text(pomodoroModel.timerString)
                            .font(.system(size: 75, weight: .heavy, design: .default))
                            .font(.subheadline)
                            .foregroundColor(Color("Letras"))
                            .rotationEffect(.init(degrees: 90))
                            .animation(.none, value: pomodoroModel.progress)
                        
                        
                        
                    }
                    .padding(60)
                    .frame(height:proxy.size.width)
                    .rotationEffect(.init(degrees: -90))
                    .animation(.easeIn, value: pomodoroModel.progress)
//                    MARK : PLAY BUTTON
                    
                    Button{
                        if pomodoroModel.isStarted{
                            
                        }else{
                            pomodoroModel.addNewTimer = true
                        }
                    }label: {
                        Image(systemName: pomodoroModel.isStarted ? "timer" : "pause" )
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                            .frame(width:80,height:80)
                            .background{
                                Circle().fill(Color("Letras"))
                            }
                            .shadow(color: Color("Azul"), radius: 10, x: 0, y: 0)
                        
                    }
                }
                
                .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .center)
            }
            
        }.padding()
            .preferredColorScheme(.light)
        
    }
//    MARK : new timer botton sheer
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PomodoroModel())
    }
}

//MARK : NOTAS DE HOME
//Geometry Reader
//Rotation EFFECT
//trim
//stroke
