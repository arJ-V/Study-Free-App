import SwiftUI

struct EventDetail: View {
    @Binding var event: Event
    @Binding var isDeleted: Bool
    @Binding var isNew: Bool
    
    @EnvironmentObject var eventData: EventData
    @Environment(\.dismiss) private var dismiss
    
    @State private var isPickingSymbol = false
    
    @FocusState var focusedTask: EventTask?
    
    var body: some View {
        List {
            Section {
                HStack {
                    Button {
                        isPickingSymbol.toggle()
                    } label: {
                        Image(systemName: event.symbol)
                            .imageScale(.large)
                            .foregroundColor(event.color)
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal, 5)


                    TextField("New Event", text: $event.title)
                        .font(.title2)
         
                }
                .padding(.top, 5)
            
                DatePicker("Date", selection: $event.date)
                    .labelsHidden()
                    .listRowSeparator(.hidden)

                Text("Tasks")
                    .fontWeight(.bold)
                
                ForEach($event.tasks) { $item in
                    TaskRow(task: $item, focusedTask: $focusedTask)
                }

                .onDelete(perform: { indexSet in
                    event.tasks.remove(atOffsets: indexSet)
                })
                
                Button {
                    let newTask = EventTask(text: "", isNew: true)
                    event.tasks.append(newTask)
                    focusedTask = newTask
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add Task")
                    }
                }
                .buttonStyle(.borderless)
            }
            
            if !isNew {
                Button(role: .destructive, action: {
                    isDeleted = true
                    dismiss()
                    eventData.delete(event)
                }, label: {
                    Text("Delete Event")
                        .font(Font.custom("SF Pro", size: 17))
                        .foregroundColor(Color(UIColor.systemRed))
                })
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }

        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .sheet(isPresented: $isPickingSymbol) {
            SymbolPicker(event: $event)
        }
    }
}

struct EventDetail_Previews: PreviewProvider {
    static var previews: some View {
        EventDetail(event: .constant(Event.example), isDeleted: .constant(false), isNew: .constant(false))
    }
}
