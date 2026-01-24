import SwiftUI
import UIExtensions

struct AIReviewView: View {
    var body: some View {
        VStack {
            Text("AI Review")
                .font(.title2)
                .bold()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}
