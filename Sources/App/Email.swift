//
//  Email.swift
//  App
//
//  Created by Arvid Kongstad on 22/05/2019.
//

import Vapor
import Mailgun

struct Email {

    func message(_ message: String) -> Mailgun.Message {
        return Mailgun.Message(
            from: sender,
            to: recipient,
            subject: "PasswordChecker",
            text: message
        )
    }

    private var sender: String {
        let domain = Environment.get(EnvKeys.mailgunDomain, "")
        return "postman@\(domain)"
    }

    private var recipient: String {
        return Environment.get(EnvKeys.recipientAddress, "")
    }

}
