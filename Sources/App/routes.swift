import Routing
import Vapor
import Mailgun

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)
public func routes(_ router: Router) throws {

    router.get { request in
        return try request.view().render("home")
    }

    router.post { request in
        return try request.content.decode(FormInput.self).flatMap(to: View.self) { input in

            let password = Environment.get(EnvKeys.password, "")

            let emailText: String
            let leafPath: String

            if input.password.lowercased() == password {
                emailText = "Correct password entered! (\(input.password))"
                leafPath = "huzzah"
            } else {
                emailText = "Incorrect password entered: \(input.password)"
                leafPath = "incorrect"
            }

            let mailgun = try request.make(Mailgun.self)
            let message = Email().message(emailText)

            return try mailgun.send(message, on: request).flatMap { response -> EventLoopFuture<View> in
                return try request.view().render(leafPath)
            }
        }
    }

    router.post("retry") { request in
        return request.redirect(to: "/")
    }

}

struct FormInput: Content {
    let password: String
}
