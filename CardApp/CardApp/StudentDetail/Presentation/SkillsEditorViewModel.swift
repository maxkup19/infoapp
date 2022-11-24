//
//  SkillsEditorViewModel.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 08.11.2022.
//

import Foundation
import Combine
import CombineExtensions

protocol SkillsEditorViewModelProtocol: ObservableObject {
    var skills: [StudentDetail.Skill] { get set }
    var state: FetchState { get }
    var showError: Bool { get set }
    
    func saveSkills()
}


final class SkillsEditorViewModel: SkillsEditorViewModelProtocol {
    @Published var skills: [StudentDetail.Skill]
    @Published var state: FetchState = .loading
    @Published var showError: Bool = false
    
    var student: StudentDetail
    private let studentUpdateSkillsUseCase: StudentUpdateSkillsUseCaseProtocol
    private var bag = Set<AnyCancellable>()
    
    init(student: StudentDetail, studentUpdateSkillsUseCase: StudentUpdateSkillsUseCaseProtocol) {
        self.student = student
        self.skills = student.skills ?? []
        self.studentUpdateSkillsUseCase = studentUpdateSkillsUseCase
    }
    
    func saveSkills() {
        student.skills = self.skills
        
        studentUpdateSkillsUseCase.updateSkills(for: student)
            .receive(on: DispatchQueue.main)
            .sink(
                weak: self,
                receiveCompletion: { unwrappedSelf, completion in
                    switch completion {
                    case .failure(_):
                        unwrappedSelf.state = .error
                        unwrappedSelf.showError = true
                    case .finished:
                        unwrappedSelf.state = .success
                    }
                },
                receiveValue: { unwrappedSelf, skills in
                    unwrappedSelf.student.skills = skills
                })
            .store(in: &bag)
    }
}
