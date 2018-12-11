//private var maxLengths = NSMapTable<UITextField, NSNumber>(keyOptions: NSPointerFunctions.Options.weakMemory, valueOptions: NSPointerFunctions.Options.strongMemory)
//
//extension UITextField {
//
//    var maxLength: Int? {
//        get {
//            return maxLengths.object(forKey: self)?.intValue
//        }
//        set {
//            removeTarget(self, action: #selector(limitLength), for: .editingChanged)
//            if let newValue = newValue {
//                maxLengths.setObject(NSNumber(value: newValue), forKey: self)
//                addTarget(self, action: #selector(limitLength), for: .editingChanged)
//            } else {
//                maxLengths.removeObject(forKey: self)
//            }
//        }
//    }
//
//    @IBInspectable var maxLengthInspectable: Int {
//        get {
//            return maxLength ?? Int.max
//        }
//        set {
//            maxLength = newValue
//        }
//    }
//
//    @objc private func limitLength(_ textField: UITextField) {
//        guard let maxLength = maxLength, let prospectiveText = textField.text, prospectiveText.count > maxLength else {
//            return
//        }
//        let selection = selectedTextRange
//        text = String(prospectiveText[..<prospectiveText.index(from: maxLength)])
//        selectedTextRange = selection
//}
