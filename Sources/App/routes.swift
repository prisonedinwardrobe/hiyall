import Routing
import Vapor

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)



struct TestResponse: Content {
    var id: String
    var title: String
    var text: String
    var date_create: TimeInterval
    var date_update: TimeInterval
    
    init(title: String, text: String) {
        
        self.title = title
        self.text = text
        self.id = UUID().uuidString
        self.date_create = Date().timeIntervalSince1970
        self.date_update = Date().timeIntervalSince1970
    }
}

struct PostDataBase: Content {
    var posts: [TestResponse] = []
}
var postDataBase = PostDataBase()

public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    router.post("") { req -> Future<HTTPStatus> in
        return try req.content.decode(TestResponse.self).map(to: HTTPStatus.self) { testResponse in
            print(testResponse.title)
            print(testResponse.text)
            
            postDataBase.posts.append(testResponse)
            print(postDataBase)
            return .ok
        }
    }
    router.get("login") { _ in
        return postDataBase.posts
    }
    
    router.get("") { _ in
        return "i gde zapros?"
    }
    
    router.get("test") { _ in
        return TestResponse(title: "aaa", text: "hi hui")
        
    }
    
    
    

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}



