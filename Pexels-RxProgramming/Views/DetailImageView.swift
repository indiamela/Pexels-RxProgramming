//
//  DetailImageView.swift
//  Pexels-RxProgramming
//
//  Created by TaishiKusunose on 2021/10/31.
//

import SwiftUI

struct DetailImageView: View {
    let image: UIImage
    let name: String
    var body: some View {
        ZStack{
            Color.black
            VStack(spacing: 30){
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
                    .foregroundColor(Color.white)
                Text(name)
                    .foregroundColor(.white)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct DetailImageView_Previews: PreviewProvider {
    static var previews: some View {
        DetailImageView(image: UIImage(systemName: "person.fill")!, name: "John")
    }
}
