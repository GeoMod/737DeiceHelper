//
//  ButtonView.swift
//  Deice737
//
//  Created by Daniel O'Leary on 2/5/21.
//

import SwiftUI

struct ButtonView: View {
	let title: String
	let backgroundColor: Color

    var body: some View {
		Text(title)
			.frame(maxWidth: .infinity, maxHeight: 50)
			.foregroundColor(.white)
			.font(.title)
			.background(RoundedRectangle(cornerRadius: 20).fill(backgroundColor))
			.shadow(color: Color.black.opacity(0.6), radius: 7, x: 5, y: 5)
			.padding()
    }
}


struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
		ButtonView(title: "Evaluate", backgroundColor: .blue)
    }
}
