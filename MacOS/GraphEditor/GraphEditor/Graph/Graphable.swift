//
//  Graphable.swift
//  Graph
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 28/08/19.
//  Copyright © 2019 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import Foundation

protocol Graphable {
    associatedtype Element: Hashable

    var description: CustomStringConvertible { get }

    func createVertex(data: Element) -> Vertex<Element>
    func add(_ type: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?)
    func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double?
    func edges(from source: Vertex<Element>) -> [Edge<Element>]?

}

extension Graphable {

    public func route(to destination: Vertex<Element>, in tree: [Vertex<Element> : Visit<Element>]) -> [Edge<Element>] {

        var vertex = destination
        var path: [Edge<Element>] = []

        while let visit = tree[vertex], case .edge(let edge) = visit {

            path = [edge] + path
            vertex = edge.source
        }
        return path
    }

    public func distance(to destination: Vertex<Element>, in tree: [Vertex<Element> : Visit<Element>]) -> Double {

        let path = route(to: destination, in: tree)
        let distances = path.flatMap({ $0.weight })
        return distances.reduce(into: 0.0, { $0 + $1 })
    }

    public func dijkstra(from source: Vertex<Element>, to destination: Vertex<Element>) -> Edge<Element>? {

        var visits: [Vertex<Element> : Visit<Element>] = [source: .source]
        var priorityQueue
    }
}
