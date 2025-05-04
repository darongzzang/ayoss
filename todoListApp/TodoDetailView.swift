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
    @State private var isEditing = false
    @State private var editedTitle = ""
    @State private var editedTargetDate = Date()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                // 제목 섹션
                VStack(alignment: .leading) {
                    Text("제목").font(.headline)
                    if isEditing {
                        TextField("제목", text: $editedTitle)
                    } else {
                        Text(item.title)
                    }
                }
                
                // 생성일 (수정 불가)
                DetailRow(title: "생성일", value: item.creationDate.formatted(date: .long, time: .shortened))
                
                // 목표일 섹션
                VStack(alignment: .leading) {
                    Text("목표일").font(.headline)
                    if isEditing {
                        DatePicker("목표일", selection: $editedTargetDate, displayedComponents: .date)
                    } else {
                        Text(item.targetDate.formatted(date: .long, time: .shortened))
                    }
                }
                
                // 상태 섹션 (기존 구현 유지)
                VStack(alignment: .leading) {
                    Text("상태").font(.headline)
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
            .navigationTitle("\(item.title)")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if isEditing {
                            item.title = editedTitle
                            item.targetDate = editedTargetDate
                            isEditing = false
                        } else {
                            editedTitle = item.title
                            editedTargetDate = item.targetDate
                            isEditing = true
                        }
                    } label: {
                        if isEditing {
                            Text("")
                        } else {
                            Image(systemName: "pencil")
                        }
                    }
                    .disabled(isEditing && editedTitle.isEmpty)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    if isEditing{
                        Button("저장") {
                            item.title = editedTitle
                            item.targetDate = editedTargetDate
                            isEditing = false
                        }
                    }
                    else {
                        Button("완료") { dismiss() }
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

