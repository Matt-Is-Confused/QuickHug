import ckdl

public extension Value {
    /*
     func fromString(_: String) -> Self {
         var value = Self()
         value.type = ckdl.KDL_TYPE_STRING
         // value.type_annotation =

         // value.string =

         return value
     }
     */
}

protocol ToValue {
    func toValue() -> Value
}

protocol FromValue {
    func fromValue() -> Value
}

typealias ValueConvertable = FromValue & ToValue

extension String: ValueConvertable {
    func fromValue() -> Value {}

    func toValue() -> Value {}
}

extension Double: ValueConvertable {
    func fromValue() -> Value {}

    func toValue() -> Value {}
}

extension Bool: ValueConvertable {
    func fromValue() -> Value {}

    func toValue() -> Value {}
}
