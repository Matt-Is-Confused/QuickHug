import ckdl

protocol KDLEmitter {
    // Going to make this take Swift Strings rather than C Stings
    // I need to confirm that ckdl no longer accesses the pointer
    // after the function returns
    func emitNode(name: String, type: String?)
}
