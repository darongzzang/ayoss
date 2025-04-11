//
//  TodoDetailView.swift
//  todoListApp
//
//  Created by 김이예은 on 4/11/25.
//

import SwiftUI
import SwiftData

struct TodoDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Bindable var item: TodoItem
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                DetailRow(title: "제목", value: item.title)
                
                DetailRow(title: "생성일", value: item.creationDate.formatted(date: .long, time: .shortened))
                
                DetailRow(title: "목표일", value: item.targetDate.formatted(date: .long, time: .shortened))
                
                VStack(alignment: .leading) {
                    Text("상태")
                        .font(.headline)
                    
                    Picker("상태", selection: $item.taskStatus) {
                        ForEach(TaskStatus.allCases, id: \.self) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("할 일 상세")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("완료") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct DetailRow: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            Text(value)
                .font(.body)
        }
    }
}

