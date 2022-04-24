//
//  FileReader.swift
//  BitPandaCore
//
//  Created by Oleg Kurgaev on 20.04.2022.
//

import Foundation

public enum FileReader {
    public static func readJSON(from file: String, bundle: Bundle = Bundle.main) -> MainDataWrapper? {
        guard let path = bundle.path(forResource: file, ofType: "json") else {
            return nil
        }

        var json: MainDataWrapper?

        do {

            guard let jsonData = try String(contentsOfFile: path).data(using: .utf8) else {
                return nil
            }

            json = try JSONDecoder().decode(MainDataWrapper.self, from: jsonData)
        } catch {
            // do nothing
        }

        return json
    }
}
