//
//  TodoListView.swift
//  todoListApp
//
//  Created by 김이예은 on 4/11/25.
//

import SwiftUI
import SwiftData

struct TodoListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var todoItems: [TodoItem]
    @State private var showingAddSheet = false
    @State private var selectedItem: TodoItem?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(todoItems) { item in
                    TodoItemRow(item: item)
                        .onTapGesture {
                            selectedItem = item
                        }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("할 일 목록")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddSheet = true
                    }) {
                        Label("추가", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddTodoView()
            }
            .sheet(item: $selectedItem) { item in
                TodoDetailView(item: item)
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(todoItems[index])
        }
    }
}

struct TodoItemRow: View {
    let item: TodoItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                Text("목표일: \(item.targetDate.formatted(date: .abbreviated, time: .omitted))")
                    .font(.caption)
            }
            
            Spacer()
            
            Circle()
                .fill(TaskStatus(rawValue: item.status)?.color ?? .gray)
                .frame(width: 12, height: 12)
        }
    }
}


