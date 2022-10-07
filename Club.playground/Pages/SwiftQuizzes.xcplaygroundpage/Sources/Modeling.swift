import Foundation

// MARK: - Response

struct Response: Decodable {
    let tabs: [Response.Tab]
}

extension Response {
    struct Tab: Decodable {
        let title: String
        let sections: [Response.Tab.Section]
    }
}

extension Response.Tab {
    struct Section: Decodable {
        private enum CodingKeys: String, CodingKey {
            case sectionType = "type"
            case label
            case value
        }
        
        private let sectionType: String
        let label: String?
        let value: String?
        
        var type: Response.Tab.Section.SectionType {
            .init(rawValue: sectionType) ?? .unknown
        }
    }
}

extension Response.Tab.Section {
    enum SectionType: String {
        case sectionHeader = "SECTION_HEADER"
        case listItem = "LIST_ITEM"
        case divider = "DIVIDER"
        case unknown
    }
}

// MARK: - Model

struct Model: Equatable {
    let tabs: [Model.Tab]
}

extension Model {
    struct Tab: Equatable {
        let title: String
        let sections: [Model.Tab.Section]
    }
}

extension Model.Tab {
    struct Section: Equatable {
        let title: String
        let items: [Model.Tab.Section.Item]
        
        func appending(_ newItem: Model.Tab.Section.Item) -> Self {
            .init(title: title, items: items + [newItem])
        }
    }
}

extension Model.Tab.Section {
    struct Item: Equatable {
        let label: String
        let value: String?
        let hasDivider: Bool
    }
}

// MARK: - Mapper

enum Mapper {
    enum Invalidated: Error {
        case sectionHeaderWithoutLabel
        case listItemWithoutLabel
    }
    
    static func makeModel(from response: Response) throws -> Model {
        var result = [Model.Tab]()

        for tab in response.tabs {
            let newTab = Model.Tab(
                title: tab.title,
                sections: try makeSections(from: tab.sections)
            )
            result.append(newTab)
        }
        
        return .init(tabs: result)
    }
    
    private static func makeSections(from sections: [Response.Tab.Section]) throws -> [Model.Tab.Section] {
        var result: [Model.Tab.Section] = []
        var newSection: Model.Tab.Section?
        var dividerCount = 0
        
        for section in sections {
            switch section.type {
            case .sectionHeader:
                guard let title = section.label else {
                    throw Invalidated.sectionHeaderWithoutLabel
                }
                
                if let newSection = newSection {
                    result.append(newSection)
                } else {
                    newSection = .init(title: title, items: [])
                }
                
            case .listItem:
                guard let label = section.label else {
                    throw Invalidated.listItemWithoutLabel
                }
                
                let newItem = Model.Tab.Section.Item(
                    label: label,
                    value: section.value,
                    hasDivider: !dividerCount.isMultiple(of: 2)
                )
                
                newSection = newSection?.appending(newItem)
                
            case .divider:
                dividerCount += 1
                
            case .unknown:
                break // Skip this for backward compatibility
            }
        }
        
        if let newSection = newSection {
            result.append(newSection)
        }
        
        return result
    }
}

import XCTest

public final class ModelingTests: XCTestCase {
    private let data = """
    {
        "tabs": [
            {
                "title": "Update",
                "sections": [
                    {
                        "type": "SOMETHING_ELSE",
                        "label": "new-label",
                        "value": "new-value"
                    }
                ]
            },
            {
                "title": "Detail",
                "sections": [
                    {
                        "type": "SECTION_HEADER",
                        "label": "new-label",
                    },
                    {
                        "type": "LIST_ITEM",
                        "label": "new-label",
                        "value": "new-value"
                    },
                    {
                        "type": "DIVIDER"
                    },
                    {
                        "type": "LIST_ITEM",
                        "label": "new-label",
                        "value": "new-value"
                    },
                    {
                        "type": "DIVIDER"
                    },
                    {
                        "type": "LIST_ITEM",
                        "label": "new-label",
                        "value": "new-value"
                    }
                ]
            }
        ]
    }
    """.data(using: .utf8)!
    
    func testMapping() throws {
        let response = try JSONDecoder().decode(Response.self, from: data)
        let model = try Mapper.makeModel(from: response)
        
        let expected = Model(tabs: [
            .init(title: "Update", sections: []),
            .init(title: "Detail", sections: [
                .init(title: "new-label", items: [
                    .init(label: "new-label", value: "new-value", hasDivider: false),
                    .init(label: "new-label", value: "new-value", hasDivider: true),
                    .init(label: "new-label", value: "new-value", hasDivider: false)
                ])
            ])
        ])
        
        XCTAssertEqual(model, expected)
    }
}
