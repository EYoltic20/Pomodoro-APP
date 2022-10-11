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
            
        }
        .padding()
        .preferredColorScheme(.light)
        .overlay(content: {
            ZStack{
                Color.black
                    .opacity(pomodoroModel.addNewTimer ? 0.25 : 0 )
                    .onTapGesture {
                        pomodoroModel.addNewTimer = false
                    }
                NewTimer()
                    .frame(maxHeight:.infinity,alignment: .bottom)
                    .offset(y:pomodoroModel.addNewTimer ? 0 : 400)

                
            }
            .animation(.easeInOut, value: pomodoroModel.addNewTimer)
        })
        
    }
    //    MARK : new timer botton sheer
    @ViewBuilder // -> MARK: - QUE ES
    func NewTimer() ->some View{
        VStack(spacing:15){
            Text("Add timer")
                .foregroundColor(.white)
                .padding(.top,10)
            
            HStack(spacing:25){
                Text("\(pomodoroModel.hour) hr")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Letras"))
                    .padding(.vertical,12)
                    .padding(.horizontal,30)
                    .background{
                        Capsule()
                            .fill(.white.opacity(0.7))
                        
                    }
                    .contextMenu{
                        contextMenuOpt(maxValue: 12, hint: "hr"){ value in
                            pomodoroModel.hour = value
                        }
                    }
                Text("\(pomodoroModel.minute) min")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Letras"))
                    .padding(.vertical,12)
                    .padding(.horizontal,30)
                    .background{
                        Capsule()
                            .fill(.white.opacity(0.7))
                        
                    }
                    .contextMenu{
                        contextMenuOpt(maxValue: 60, hint: "min"){ value in
                            pomodoroModel.minute = value
                        }
                    }
                Text("\(pomodoroModel.seconds) sec")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Letras"))
                    .padding(.vertical,12)
                    .padding(.horizontal,30)
                    .background{
                        Capsule()
                            .fill(.white.opacity(0.7))
                        
                    }
                    .contextMenu{
                        contextMenuOpt(maxValue: 60, hint: "sec"){ value in
                            pomodoroModel.seconds = value
                        }
                    }
            }
            .padding(.top,20)
            Button{
                
            }label: {
                Text("Save")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .padding(.horizontal,100)
                    .background{
                        Capsule()
                            .fill(Color("Letras"))
                    }
            }
            .disabled(pomodoroModel.seconds == 0)
            .opacity(pomodoroModel.seconds == 0 ? 0.5 : 1)
            .padding(.top)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background{
            RoundedRectangle(cornerRadius: 10,style: .continuous)
                .fill(Color("Azul"))
                .ignoresSafeArea()
        }
    }
    //    MARK: Reusable context menu
    @ViewBuilder
    func contextMenuOpt(maxValue:Int,hint:String, onClick: @escaping (Int)->())->some View{
        ForEach(0...maxValue,id:\.self){ value in
            Button("\(value) \(hint)"){
                onClick(value)
            }
        }
    }
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
