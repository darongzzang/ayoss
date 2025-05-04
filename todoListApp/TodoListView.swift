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
            ZStack {
                VStack(alignment: .leading) {
                    Text("할 일 목록")
                        .fontWeight(.bold)
                        .font(.system(size: 32))
                        .foregroundStyle(.accent)
                        .padding(.top, 32)
                        .padding(.horizontal, 16)
                    List {
                        ForEach(todoItems) { item in
                            TodoItemRow(item: item)
                                .onTapGesture {
                                    selectedItem = item
                                }
                        }
                        .onDelete(perform: deleteItems)
                    }
//                    .listStyle(.grouped)
                }
                
                VStack {
                    Spacer()
                    Button(action: {
                        showingAddSheet = true
                    }) {
                        Text("할 일 기록하기")
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                    }
                    .padding(.bottom, 50)
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


