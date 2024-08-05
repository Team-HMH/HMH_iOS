//
//  PickerView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 4/8/24.
//

import SwiftUI

struct PickerView: UIViewRepresentable {
    var times: [String]
    @Binding var selectedTimes: String
    @ObservedObject var viewModel: OnboardingViewModel
    
    func makeUIView(context: Context) -> UIPickerView {
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        pickerView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        pickerView.dataSource = context.coordinator
        pickerView.delegate = context.coordinator
        
        return pickerView
    }
    
    func updateUIView(_ pickerView: UIPickerView, context: Context) {
        if let selectedIndex = times.firstIndex(of: selectedTimes) {
            pickerView.selectRow(selectedIndex, inComponent: 0, animated: true)
        }
    }
    
    func makeCoordinator() -> PickerCoordinator {
        return PickerCoordinator(times: times, selectedTime: $selectedTimes, viewModel: viewModel)
    }
}

class PickerCoordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    @ObservedObject var viewModel: OnboardingViewModel
    var times: [String]
    var selectedTime: Binding<String>
    
    init(times: [String], selectedTime: Binding<String>, viewModel: OnboardingViewModel) {
        self.times = times
        self.selectedTime = selectedTime
        self.viewModel = viewModel
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return times.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return times[row]
    }
     
     func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
         let time = UIColor(.whiteText)
         let font = UIFont(name: "Pretendard-Medium", size: 22)

         
         let attributes: [NSAttributedString.Key: Any] = [
             NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): time,
             NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): font
         ]
         
         return NSAttributedString(string: times[row], attributes: attributes)
     }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedTime.wrappedValue = times[row]
        viewModel.isCompleted = true
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 53
    }
}

