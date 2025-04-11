//
//  Item.swift
//  todoListApp
//
//  Created by 김이예은 on 4/11/25.
//

import SwiftUI
import SwiftData

// 할 일 상태를 나타내는 열거형
enum TaskStatus: String, Codable, CaseIterable {
    case notStarted = "완료 전"
    case inProgress = "실행 중"
    case completed = "완료"
    
    var color: Color {
        switch self {
        case .notStarted: return .red
        case .inProgress: return .green
        case .completed: return .blue
        }
    }
}

// SwiftData 모델 정의
@Model
class TodoItem {
    var title: String
    var creationDate: Date
    var targetDate: Date
    var status: TaskStatus.RawValue
    
    init(title: String, targetDate: Date, status: TaskStatus = .notStarted) {
        self.title = title
        self.creationDate = Date()
        self.targetDate = targetDate
        self.status = status.rawValue
    }
    
    var taskStatus: TaskStatus {
        get {
            return TaskStatus(rawValue: status) ?? .notStarted
        }
        set {
            status = newValue.rawValue
        }
    }
}
