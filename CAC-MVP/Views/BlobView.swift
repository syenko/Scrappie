//
//  BlobView.swift
//  CAC-MVP
//
//  Created by Sabrina on 11/1/22.
//

import SwiftUI

struct BlobView: View {
    @EnvironmentObject var controller : ViewController
    var body: some View {
        ScrollView(.vertical) {
            Text("\(controller.blobData.numSelectedBlobs) / 3 Selected")
                .font(.headline)
            
            LazyVGrid(columns:
                [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                ]) {
                    ForEach(controller.blobData.blobs, id: \.id) { blob in
                        blob.icon
                            .onTapGesture {
                                controller.blobData.toggleSelectBlob(blob: blob)
                            }
                    }
                }
        }
        .navigationTitle("Badge Buddies")
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        BlobView()
            .environmentObject(ViewController())
    }
}
