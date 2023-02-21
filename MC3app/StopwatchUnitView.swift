//
//  StopwatchUnitView.swift
//  MC3app
//
//  Created by Aryan Garg on 21/02/23.
//

import SwiftUI


struct StopwatchUnitView: View {

    var timeUnit: Int

    /// Time unit expressed as String.
    /// - Includes "0" as prefix if this is less than 10
    var timeUnitStr: String {
        let timeUnitStr = String(timeUnit)
        return timeUnit < 10 ? "0" + timeUnitStr : timeUnitStr
    }

    var body: some View {
        HStack (spacing: 2) {
            Text(timeUnitStr.substring (index: 0)).frame(width: 20)
            Text(timeUnitStr.substring(index: 1)).frame(width: 40)
        }
    }
}

extension String {
    func substring(index: Int) -> String {
        let arrayString = Array(self)
        return String(arrayString[index])
    }
}

