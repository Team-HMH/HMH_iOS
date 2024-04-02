//
//  GoalTimeView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 3/24/24.
//


import SwiftUI

struct GoalTimeView: View {
    var colors = ["2", "3", "4", "5", "0"]
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        HStack {
            PickerView(colors: colors, selectedColor: $viewModel.isSelectedPicker, viewModel: viewModel)
                .frame(width: 67)
            Text("시간")
                .font(.text2_medium_20)
                .foregroundColor(.gray2)
        }
    }
}

struct PickerView: UIViewRepresentable {
    var colors: [String]
    @Binding var selectedColor: String
    @ObservedObject var viewModel: OnboardingViewModel
    
    func makeUIView(context: Context) -> UIPickerView {
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        pickerView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        pickerView.dataSource = context.coordinator
        pickerView.delegate = context.coordinator
        
        return pickerView
    }
    
    func updateUIView(_ pickerView: UIPickerView, context: Context) {
        if let selectedIndex = colors.firstIndex(of: selectedColor) {
            pickerView.selectRow(selectedIndex, inComponent: 0, animated: true)
        }
    }
    
    func makeCoordinator() -> PickerCoordinator {
        return PickerCoordinator(colors: colors, selectedColor: $selectedColor, viewModel: viewModel)
    }
}

class PickerCoordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    @ObservedObject var viewModel: OnboardingViewModel
    var colors: [String]
    var selectedColor: Binding<String>
    
    init(colors: [String], selectedColor: Binding<String>, viewModel: OnboardingViewModel) {
        self.colors = colors
        self.selectedColor = selectedColor
        self.viewModel = viewModel
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colors[row]
    }
     
     func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
         let color = UIColor(.whiteText)
         let font = UIFont(name: "Pretendard-Medium", size: 22)

         
         let attributes: [NSAttributedString.Key: Any] = [
             NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): color,
             NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): font
         ]
         
         return NSAttributedString(string: colors[row], attributes: attributes)
     }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedColor.wrappedValue = colors[row]
        viewModel.isCompleted = true
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 53
    }
}


//#Preview {
//    GoalTimeView(, selectedColor: <#Binding<String>#>)
//}
