import SwiftSyntax
import SwiftSemantics

let tree = try SyntaxParser.parse(source: "func sample1(with x:Int) { print(111 + x) }")
let collector = DeclarationCollector()
collector.walk(tree)
for fx in collector.functions {
    print("function name: \(fx.identifier)")
    precondition(fx.identifier == "sample1")
    for arg in fx.signature.input {
        print("- argument")
        print("  - external name: \(arg.firstName ?? "")")
        print("  - internal name: \(arg.secondName ?? "")")
        print("  - type expr: \(arg.type ?? "")")
    }
    /// Or just `dump(fx)` to print everything.
    dump(fx)
}
