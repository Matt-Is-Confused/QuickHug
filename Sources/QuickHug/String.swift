import ckdl

extension String {
    func toOwnedString() -> OwnedStr {
        return withCString { cString in
            // Get a CString pointer to the internal buffer of the String
            var cstr = ckdl.kdl_str_from_cstr(cString)

            // Clone the internal buffer into a C struct that the library can use
            let owned = withUnsafePointer(to: &cstr) { ptr in
                ckdl.kdl_clone_str(ptr)
            }

            // Return the C copy of the Swift String
            return owned
        }
    }

    func getUnsafeStrPointer() -> Str {
        return withCString { ptr in
            ckdl.kdl_str_from_cstr(ptr)
        }
    }

    // init?(kdlStr: Str) {
    //    self.init(cString: kdlStr.data)
    // }
}

extension Str {
    func toString() -> String? {
        guard let ptr = data else {
            return nil
        }
        return String(cString: ptr)
    }
}

extension OwnedStr {
    func toString() -> String {
        return String(cString: data)
    }
}
