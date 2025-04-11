//
//  AddTodoView.swift
//  todoListApp
//
//  Created by 김이예은 on 4/11/25.
//

import SwiftUI
import SwiftData

struct AddTodoView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var targetDate = Date()
    @State private var status: TaskStatus = .notStarted
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("할 일", text: $title)
                
                DatePicker("목표일", selection: $targetDate, displayedComponents: .date)
                
                Picker("상태", selection: $status) {
                    ForEach(TaskStatus.allCases, id: \.self) { status in
                        Text(status.rawValue).tag(status)
                    }
                }
            }
            .navigationTitle("새 할 일 추가")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("저장") {
                        addItem()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
    
    private func addItem() {
        let newItem = TodoItem(title: title, targetDate: targetDate, status: status)
        modelContext.insert(newItem)
        dismiss()
    }
}

