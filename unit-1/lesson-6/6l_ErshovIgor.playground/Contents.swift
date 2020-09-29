import UIKit

class Queue<TEntity> {
    private var elements: [TEntity] = []
    
    init()
    {
    }
    
    init(_ elements : [TEntity]) {
        self.elements = elements
    }
    
    public var isEmpty: Bool {
        return elements.isEmpty
    }
    
    public func enqueue(_ element: TEntity) {
        elements.append(element)
    }
    
    public func dequeue() -> TEntity! {
        throwIfEmpty()
        let firstElement = elements.first;
        elements.removeFirst()
        return firstElement
    }
    
    public func peek() -> TEntity! {
        throwIfEmpty()
        return elements.first
    }
    
    subscript(position: Int) -> TEntity? {
        throwIfEmpty()
        return (position < 0 || position > elements.count - 1) ? nil : elements[position]
    }
    
    public func filter(predicate: (TEntity) -> Bool) -> [TEntity] {
        throwIfEmpty()
        var array = [TEntity]()
        for element in elements {
            if (predicate(element)){
                array.append(element)
            }
        }
        return array
    }
    
    public func select<TResult>(predicate: (TEntity) -> TResult) -> [TResult] {
        throwIfEmpty()
        var array = [TResult]()
        for element in elements {
            array.append(predicate(element))
        }
        return array
    }
    
    private func throwIfEmpty() {
        precondition(elements.count > 0, "Empty collection!")
    }
}

extension Queue: CustomStringConvertible {
    var description: String {
        return String(describing: elements)
    }
}

extension Queue: Sequence {
    typealias Iterator = IndexingIterator<[TEntity]>
    
    func makeIterator() -> Iterator {
        return elements.makeIterator()
    }
}

class SampleItem: CustomStringConvertible {
    let name: String
    let value: Int
    init(_ name: String, _ value: Int) {
        self.name = name
        self.value = value
    }
    
    var description: String {
        return "Name: \(name). Value: \(value)"
    }
}


var queue = Queue<SampleItem>()
queue.enqueue(SampleItem("Test 1", 1))
queue.enqueue(SampleItem("Test 2", 2))
queue.enqueue(SampleItem("Test 3", 3))
queue.enqueue(SampleItem("Test 4", 4))
queue.enqueue(SampleItem("Test 5", 5))
queue.enqueue(SampleItem("Test 6", 6))
print(queue)

var arrSelected = queue.select(){$0.value}
print(arrSelected)

var arrFiltered = queue.filter() {$0.value % 2 == 0}
print (arrFiltered)

var first = queue.dequeue()
print(first)
print(queue)
print(queue.peek())
