//
//  textField.swift
//  Pexels-RxProgramming
//
//  Created by TaishiKusunose on 2021/10/30.
//

import SwiftUI

struct textField: View {
    @State var text: String = ""
    var body: some View {
        HStack(alignment:.center,spacing: 20) {
            TextField("search", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button {
//                searchAction()
            } label: {
                Text("検索")
                    .fontWeight(.bold)
                    .frame(width: 80, height: 40, alignment: .center)
                    .background(Color.yellow)
                    .cornerRadius(10)
            }
        }
        .padding()
        .accentColor(.black)
    }
}

struct textField_Previews: PreviewProvider {
    static var previews: some View {
        textField()
    }
}
