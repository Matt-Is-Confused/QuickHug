import ckdl

// typealias ParseOptions = ckdl.kdl_parse_option
enum ParseOptions: Int {
    case defaults = 0
    case emitComments = 1

    func ctype() -> ckdl.kdl_parse_option {
        switch self {
        case .defaults: return ckdl.KDL_DEFAULTS
        case .emitComments: return ckdl.KDL_EMIT_COMMENTS
        }
    }
}

protocol KDLParser {
    func nextEvent() -> EventData?
}

class StringParser: KDLParser {
    private var parser: OpaquePointer
    private var text: OwnedStr

    init?(doc: String, opt: ParseOptions) {
        text = doc.withCString { cString in
            var cstr = ckdl.kdl_str_from_cstr(cString)
            let owned = withUnsafePointer(to: &cstr) { ptr in
                ckdl.kdl_clone_str(ptr)
            }
            return owned
        }

        let str = withUnsafePointer(to: &text) { ptr in
            ckdl.kdl_borrow_str(ptr)
        }

        guard let parserPtr = ckdl.kdl_create_string_parser(str, opt.ctype()) else {
            return nil
        }
        parser = parserPtr
    }

    deinit {
        withUnsafeMutablePointer(to: &self.text) { ptr in
            ckdl.kdl_free_string(ptr)
        }
        withUnsafeMutablePointer(to: &self.parser) { ptr in
            ckdl.kdl_destroy_parser(ptr.pointee)
        }
    }

    func nextEvent() -> EventData? {
        guard let event = ckdl.kdl_parser_next_event(parser) else {
            return nil
        }

        // TODO:

        return EventData()
    }
}

// TODO class StreamParser: KDLParser {}
