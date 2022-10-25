//
//  HelpView.swift
//  CAC-MVP
//
//  Created by Sabrina on 10/24/22.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        Text("Please contact your local officials for any help required.")
            .navigationTitle("Help")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
