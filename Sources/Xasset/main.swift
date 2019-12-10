import Foundation

import Commander

Group {
    $0.command(
        "export",
        Argument<String>("at", description: "xcasset path"),
        Argument<String>("to", description: "export path")
    ) { at, to in
        try export(at: URL(fileURLWithPath: at), to: URL(fileURLWithPath: to))
    }
    $0.command(
        "replace",
        Argument<String>("at", description: "images path"),
        Argument<String>("to", description: "xcasset path")
    ) { at, to in
        try replace(at: URL(fileURLWithPath: at), to: URL(fileURLWithPath: to))
    }
}.run()

