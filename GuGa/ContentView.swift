//
//  ContentView.swift
//  GuGa
//
//  Created by Максим on 22.12.2020.
//

import SwiftUI

struct teamTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.white)
            .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
            .shadow(color: .black, radius: 6, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
    }
}

extension View {
    func teamTitled() -> some View{
        self.modifier(teamTitle())
    }
}
extension Image {
    func flagImage() -> some View{
        self
            .renderingMode(/*@START_MENU_TOKEN@*/.original/*@END_MENU_TOKEN@*/)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.black, lineWidth: 3))
            .shadow(color: .black, radius: 7, x: 5.0, y: 5.0)
    }
}

struct ContentView: View {
    
    @State private var csgoTeams = ["Team Liquid", "Vitality", "BIG", "Virtus Pro", "Team Spirit"].shuffled()
    @State private var selectedTeam = Int.random(in: 0...4)
    @State private var showScore = false
    @State private var testResult = ""
    @State private var gameScore = 0
    
    var body: some View {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.pink, .black]), startPoint: /*@START_MENU_TOKEN@*/.topLeading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.bottomTrailing/*@END_MENU_TOKEN@*/).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack(spacing: 30){
                    HStack{
                        Spacer()
                        Text("Score: \(gameScore)").teamTitled().font(.title)
                    }
                Spacer()
                VStack{
                    Text("The homeland of")
                    Text("\(csgoTeams[selectedTeam]) is")
                        }.teamTitled()
                    ForEach(0..<4) { team in
                    Button(action: {
                        self.flagTapped(team: team)
                    }){
                        Image(self.csgoTeams[team]).flagImage()
                                        }
                                }
                Spacer()
            }
            }.alert(isPresented: $showScore){
                Alert(title: Text(testResult),
                      message: Text("Your score is \(gameScore)"),
                      dismissButton: .default(Text("Continue")){
                    self.wantToContinue()
                })
            }
        }

    func flagTapped(team: Int){
        if team == selectedTeam{
            testResult = "Correct"
            gameScore+=1
        }else{
            testResult = "Wrong"
            gameScore-=1
        }
        showScore = true
    }
    func wantToContinue() {
        csgoTeams.shuffle()
        selectedTeam = Int.random(in: 0...4)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
