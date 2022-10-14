//
//  ContentView.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 09.10.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                header
                
                socialMediaRow
                
                Divider()
                
                skillsBox
                
                homework
                
            }
            .padding(16)
        }
    }
    
    private var header: some View {
        VStack {
            Text("Maksym Kupchenko")
                .font(.system(size: 32, weight: .bold))
            
            Image("ProfilePhoto")
                .resizable()
                .frame(width: 140, height: 140)
                .clipShape(Circle())
            
            Text("🍏 iOS developer")
                .font(.system(size: 16))
                .foregroundColor(.gray)
            
        }
    }
    
    private var socialMediaRow: some View {
        HStack {
            Spacer()
            SMItemView(imageName: "slack", title: "Slack", destination: "https://etneteramobil-tjp5021.slack.com/team/U044SGWRQSU")
            Spacer()
            SMItemView(imageName: "email", title: "E-mail", destination: "mailto:maxkup19@gmail.com")
            Spacer()
            SMItemView(imageName: "linkedin", title: "Linkedin", destination: "https://www.linkedin.com/in/maksym-kupchenko-999067207/")
            Spacer()
        }
    }
    
    private var skillsBox: some View {
        VStack(alignment: .leading) {
            Text("Skills")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color("textColor"))
            
            VStack(alignment: .leading, spacing: 16) {
                ExperienceRowView(imageName: "swift", value: 7)
                ExperienceRowView(imageName: "apple", value: 9)
                ExperienceRowView(imageName: "kotlin", value: 1)
                ExperienceRowView(imageName: "android", value: 5)
            }
            .padding(32)
            .box()
            
        }
    }
    
    private var homework: some View {
        VStack(alignment: .leading) {
            Text("Homework")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color("textColor"))
         
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(1...6, id: \.self) { value in
                        HomeworkItemView(number: value,
                                         pushed: Bool.random(),
                                         reviewed: Bool.random(),
                                         accepted: Bool.random())
                        .padding(.vertical)
                        .frame(width: 200)
                        
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
