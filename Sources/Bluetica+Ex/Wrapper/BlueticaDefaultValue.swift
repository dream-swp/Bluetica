//
//  BlueticaDefaultValue.swift
//  Bluetica
//
//  Created by Dream on 2025/8/17.
//

// MARK: - BlinkDefaultValue
/// Blink Property Wrapper, Set Default Value
@propertyWrapper
public struct BlueticaDefaultValue<Element> {

    /// default value
    public let defaultValue: Element

    /// value
    private var value: Element?

    public var wrappedValue: Element? {
        get { value }
        set { value = aValue { value } }
    }
    
    private var aValue: (() -> (Element?)) -> Element? {
        return {
            let value = $0()
            return value == nil ? defaultValue : value
        }
    }
    
    public init(_ defaultValue: Element, value: Element? = nil) {
        self.defaultValue = defaultValue
        self.value = aValue { value }
    }

}
