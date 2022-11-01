import SwiftUI

struct EventRow: View {
    
    @ScaledMetric var imageWidth: CGFloat = 40
    
    let event: Event
    
    var body: some View {
        HStack {
            Label {
                VStack(alignment: .leading, spacing: 5) {
                    Text(event.title)
                        .fontWeight(.bold)

                    Text(event.date.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            } icon: {
                Image(systemName: event.symbol)
                    .foregroundStyle(event.color)
                    .padding(.trailing, 15)
            }
            .labelStyle(CustomLabelStyle())
        }
        .badge(event.remainingTaskCount - event.containsEmptyTextCount)
        
        if event.isComplete {
            Image(systemName: "checkmark")
                .foregroundStyle(.secondary)
        }
    }
}

struct EventRow_Previews: PreviewProvider {
    static var previews: some View {
        EventRow(event: Event.example)
    }
}
