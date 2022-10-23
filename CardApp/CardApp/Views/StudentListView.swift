//
//  StartView.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 17.10.2022.
//

import SwiftUI

struct StudentListView: View {
    
    @State private var selection: Platform = .all
    
    let students: [Student] = .students
    
    var body: some View {
        NavigationStack {
            
            VStack {
                Picker("Participants", selection: $selection) {
                    ForEach(Platform.allCases) { value in
                        Text(value.rawValue).tag(value)
                    }
                }
                .pickerStyle(.segmented)
                
                
                List(
                    students
                        .filter {
                            switch selection {
                            case .all:
                                return true
                            case .android:
                               return  $0.platform == .android
                            case .iOS:
                               return  $0.platform == .iOS
                            }
                        }
                        .sorted(by: { $0.fullName < $1.fullName })
                ) { student in
                    NavigationLink {
                        StudentView(student: student)
                            .navigationTitle(student.fullName)
                    } label: {
                        StudentRowView(student: student)
                    }
                    
                }
                .listStyle(.plain)
            }
            .navigationTitle("Participants")
        }
    }
}

struct StudentListView_Previews: PreviewProvider {
    static var previews: some View {
        StudentListView()
    }
}
