//
//  ChatCompletion.swift
//
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public struct ChatCompletion: Codable, Hashable {

    /// A unique identifier for the chat completion.
    public let id: String
    /// A list of chat completion choices. Can be more than one if n is greater than 1.
    public let choices: [Self.Choice]
    /// The Unix timestamp (in seconds) of when the chat completion was created.
    public let created: TimeInterval
    /// The model used for the chat completion.
    public let model: String
    /// The object type, which is always chat.completion.
    public let object: String
    /// This fingerprint represents the backend configuration that the model runs with.
    /// Can be used in conjunction with the seed request parameter to understand when backend changes have been made that might impact determinism.
    public let system_fingerprint: String?
    /// Usage statistics for the completion request.
    public let usage: Self.CompletionUsage?

    public struct Choice: Codable, Hashable {
        public typealias ChatCompletionMessage = ChatCompletionCreateParams.ChatCompletionMessageParam

        /// The reason the model stopped generating tokens. This will be stop if the model hit a natural stop point or a provided stop sequence, length if the maximum number of tokens specified in the request was reached, content_filter if content was omitted due to a flag from our content filters, tool_calls if the model called a tool, or function_call (deprecated) if the model called a function.
        public let finish_reason: String?
        /// The index of the choice in the list of choices.
        public let index: Int
        /// Log probability information for the choice.
        public let logprobs: Self.ChoiceLogprobs?
        /// A chat completion message generated by the model.
        public let message: Self.ChatCompletionMessage

        public enum FinishReason: String, Codable, Hashable {
            case stop
            case length
            case tool_calls
            case content_filter
            case function_call
        }

        public struct ChoiceLogprobs: Codable, Hashable {

            public let content: [Self.ChatCompletionTokenLogprob]?

            public struct ChatCompletionTokenLogprob: Codable, Hashable {

                /// The token.
                public let token: String
                /// A list of integers representing the UTF-8 bytes representation of the token.
                /// Useful in instances where characters are represented by multiple tokens and
                /// their byte representations must be combined to generate the correct text
                /// representation. Can be `null` if there is no bytes representation for the token.
                public let bytes: [Int]?
                /// The log probability of this token.
                public let logprob: Double
                /// List of the most likely tokens and their log probability, at this token position.
                /// In rare cases, there may be fewer than the number of requested `top_logprobs` returned.
                public let top_logprobs: [TopLogprob]

                public struct TopLogprob: Codable, Hashable {

                    /// The token.
                    public let token: String
                    /// A list of integers representing the UTF-8 bytes representation of the token.
                    /// Useful in instances where characters are represented by multiple tokens and their byte representations must be combined to generate the correct text representation. Can be `null` if there is no bytes representation for the token.
                    public let bytes: [Int]?
                    /// The log probability of this token.
                    public let logprob: Double
                }
            }
        }
    }

    public struct CompletionUsage: Codable, Hashable {

        /// Number of tokens in the generated completion.
        public let completion_tokens: Int
        /// Number of tokens in the prompt.
        public let prompt_tokens: Int
        /// Total number of tokens used in the request (prompt + completion).
        public let total_tokens: Int
    }
}

extension ChatCompletion: Identifiable {}

extension ChatCompletionCreateParams.ChatCompletionMessageParam {

    public init(from decoder: Decoder) throws {
        let messageContainer = try decoder.container(keyedBy: Self.ChatCompletionMessageParam.CodingKeys.self)
        switch try messageContainer.decode(Role.self, forKey: .role) {
        case .system:
            self = try .system(.init(from: decoder))
        case .user:
            self = try .user(.init(from: decoder))
        case .assistant:
            self = try .assistant(.init(from: decoder))
        case .tool:
            self = try .tool(.init(from: decoder))
        }
    }
}

extension ChatCompletionCreateParams.ChatCompletionMessageParam.ChatCompletionUserMessageParam.Content {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            let string = try container.decode(String.self)
            self = .string(string)
            return
        } catch {}
        do {
            let text = try container.decode(ChatCompletionContentPartTextParam.self)
            self = .chatCompletionContentPartTextParam(text)
            return
        } catch {}
        do {
            let image = try container.decode(ChatCompletionContentPartImageParam.self)
            self = .chatCompletionContentPartImageParam(image)
            return
        } catch {}
        throw DecodingError.typeMismatch(Self.self, .init(codingPath: [Self.CodingKeys.string, CodingKeys.chatCompletionContentPartTextParam, CodingKeys.chatCompletionContentPartImageParam], debugDescription: "Content: expected String, ChatCompletionContentPartTextParam, ChatCompletionContentPartImageParam"))
    }
}
