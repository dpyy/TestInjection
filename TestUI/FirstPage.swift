

import SwiftUI

struct FirstPage: View {
    @EnvironmentObject var test: Test
    var body: some View {
        Text("First Page \(test.name)")
    }
}

struct FirstPage_Previews: PreviewProvider {
    static var previews: some View {
        FirstPage()
    }
}
