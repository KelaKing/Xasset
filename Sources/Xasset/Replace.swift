//
//  Replace.swift
//  Xasset
//
//  Created by KelaKing on 2019/12/10.
//

import Foundation
import SwiftShell

func replace(at: URL, to: URL) throws {
    guard Files.fileExists(atPath: at.path) else {
        exit(errormessage: "\(at) no exist")
    }
    guard Files.fileExists(atPath: to.path) else {
        exit(errormessage: "\(to) no exist")
    }

    let resourceKeys: [URLResourceKey] = [.nameKey, .isDirectoryKey]

    let xcassetEnumerator = Files.enumerator(
        at: to,
        includingPropertiesForKeys: resourceKeys,
        options: [
            .skipsHiddenFiles,
        ],
        errorHandler: nil
    )!

    var count = 0
    for case let fileURL as URL in xcassetEnumerator {
        guard let resourceValues = try? fileURL.resourceValues(forKeys: Set(resourceKeys)),
            let isDirectory = resourceValues.isDirectory,
            !isDirectory,
            let name = resourceValues.name,
            name.hasSuffix(".png") else {
                continue
        }
        let sourceURL = at.appendingPathComponent(name)
        if Files.fileExists(atPath: sourceURL.path) {
            try Files.removeItem(at: fileURL)
            try Files.copyItem(at: sourceURL, to: fileURL)
            count += 1
        }

    }
    main.stdout.print("replace \(count) images 👏")
}
