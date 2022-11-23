//
//  SkillsEditorView.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 08.11.2022.
//

import SwiftUI

struct SkillsEditorView<SkillEditorVM: SkillsEditorViewModelProtocol>: View {
    
    @ObservedObject private var skillsEditorViewModel: SkillEditorVM
    @Environment(\.dismiss) private var dismiss
    
    init(skillsEditorviewModel: SkillEditorVM) {
        self.skillsEditorViewModel = skillsEditorviewModel
    }
    
    var body: some View {
        
        VStack(alignment: .trailing) {
            
            Button("Save") {
                skillsEditorViewModel.saveSkills()
            }
            
            ForEach($skillsEditorViewModel.skills) { skill in
                Stepper(value: skill.value) {
                    SkillView(imageName: skill.wrappedValue.skillType.rawValue, value: skill.wrappedValue.value)
                    
                }
                .frame(height: 50)
            }
            
            Spacer()
            
            HStack {
                
                if skillsEditorViewModel.skills.count != 0 {
                    Menu {
                        ForEach(StudentDetail.Skill.SkillType.allCases) { type in
                            if skillsEditorViewModel.skills.map(\.skillType)
                                .contains(type) {
                                Button(type.rawValue) {
                                    skillsEditorViewModel.skills.removeAll { skill in
                                        skill.skillType == type
                                    }
                                }
                            }
                        }
                        
                    } label: {
                        Image(systemName: "minus.circle")
                            .foregroundColor(Color.red)
                            .font(.title)
                    }
                }
                
                if skillsEditorViewModel.skills.count != StudentDetail.Skill.SkillType.allCases.count {
                    Menu {
                        ForEach(StudentDetail.Skill.SkillType.allCases) { type in
                            if !skillsEditorViewModel.skills.map(\.skillType)
                                .contains(type) {
                                Button(type.rawValue) {
                                    skillsEditorViewModel.skills
                                        .append(StudentDetail.Skill(skillType: type, value: 1))
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(Color.green)
                            .font(.title)
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .alert("Downloading error...", isPresented: $skillsEditorViewModel.showError) {
            Button {
                skillsEditorViewModel.saveSkills()
            } label: {
                Text("Retry")
            }
        }
        .onChange(of: skillsEditorViewModel.state) { state in
            if state == .success {
                dismiss()
            }
        }
        
        
    }
}

struct SkillsEditorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SkillsEditorView(skillsEditorviewModel: SkillsEditorViewModel(student: Mock.redactedStudentDetail, studentRepo: CometStudentRepository()))
        }
    }
}
