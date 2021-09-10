//
//  WorkspaceViewModel.swift
//  contributrack
//
//  Created by Ayush Raman on 9/9/21.
//

import Combine

final class WorkspaceRepositoryViewModel: ObservableObject {
    @Published private var workspaceRepository = WorkspaceRepository()
    @Published var workspaces = [Workspace]()
    private var cancellables = Set<AnyCancellable>()
    init() {
//        workspaceRepository.$workspaces
//            .assign(to: \.workspaces, on: self)
//            .store(in: &cancellables)
        workspaces = []
    }
    func create(_ workspace: Workspace) {
        add(workspace)
    }
    
    func add(_ workspace: Workspace) {
        workspaces.append(workspace)
    }
}

