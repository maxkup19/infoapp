//
//  SkillsEditorViewModel.swift
//  CardApp
//
//  Created by Maksym Kupchenko on 08.11.2022.
//

import Foundation
import Combine

class SkillsEditorViewModel: ObservableObject {
    @Published var skills: [StudentDetail.Skill]
    @Published var state: FetchState = .loading
    
    var student: StudentDetail
    private let studentRepo: StudentRepository = .init()
    private var bag = Set<AnyCancellable>()
    
    init(student: StudentDetail) {
        self.student = student
        self.skills = student.skills ?? []
    }
    
    func saveSkills() {
        student.skills = self.skills
    
        studentRepo.updateSkills(for: student)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .failure(_):
                        self?.state = .error
                    case .finished:
                        self?.state = .success
                    }
                },
                receiveValue: { [weak self] skills in
                    self?.student.skills = skills
            })
            .store(in: &bag)
    }
}
