//
//  Encoders.swift
//  Codable
//
//  Created by Alex Ramey on 1/6/18.
//  Copyright © 2018 test. All rights reserved.
//

import Foundation

protocol DonutFileIO {
    var encoder: EncodableEncoder { get }
    var decoder: DecodableDecoder { get }
    var fileName: String { get }
}

struct JsonFileIO: DonutFileIO {
    var encoder: EncodableEncoder = JSONEncoder()
    var decoder: DecodableDecoder = JSONDecoder()
    let fileName = "donuts.json"
}

struct PlistFileIO: DonutFileIO {
    let encoder: EncodableEncoder = PropertyListEncoder()
    let decoder: DecodableDecoder = PropertyListDecoder()
    let fileName: String = "donuts.plist"
}

extension DonutFileIO {
    func writeDonuts(donuts: [KrispyKremeDonut]) {
        do{
            let data = try encoder.encode(donuts)
            if let url = getURLForFileName(fileName: self.fileName){
                try data.write(to: url)
            } else {
                print("🔥")
            }
        } catch {
            print("🔥🔥")
        }
    }
    
    func readDonuts() -> [KrispyKremeDonut] {
        if let url = getURLForFileName(fileName: self.fileName) {
            do {
                let data = try Data(contentsOf: url)
                return try decoder.decode([KrispyKremeDonut].self, from: data)
            } catch {
                print("🔥🔥🔥")
            }
        } else {
            print("🔥🔥🔥🔥")
        }
        
        return []
    }
    
    private func getURLForFileName(fileName: String) -> URL? {
        if let documentDirectory = try? FileManager.default.url(for: .documentDirectory,
                                                        in: .userDomainMask,
                                                        appropriateFor:nil,
                                                        create:false) {
            return documentDirectory.appendingPathComponent(fileName)
        }
        
        return nil
    }
}



// Details to make this work
protocol EncodableEncoder {
    func encode<T>(_ value: T) throws -> Data where T : Encodable
}

protocol DecodableDecoder {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

extension JSONEncoder : EncodableEncoder{}
extension JSONDecoder : DecodableDecoder{}
extension PropertyListEncoder : EncodableEncoder{}
extension PropertyListDecoder : DecodableDecoder{}
