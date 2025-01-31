//
//  OpenAIProtocol+Async.swift
//
//
//  Created by Maxime Maheo on 10/02/2023.
//

import Foundation

@available(iOS 13.0, *)
@available(macOS 10.15, *)
@available(tvOS 13.0, *)
@available(watchOS 6.0, *)
public extension OpenAIProtocol {

    func images_generate(
        query: ImageGenerateParams
    ) async throws -> ImagesResponse {
        try await withCheckedThrowingContinuation { continuation in
            images_generate(query: query) { result in
                switch result {
                case let .success(success):
                    return continuation.resume(returning: success)
                case let .failure(failure):
                    return continuation.resume(throwing: failure)
                }
            }
        }
    }

    func images_edit(
        query: ImageEditParams
    ) async throws -> ImagesResponse {
        try await withCheckedThrowingContinuation { continuation in
            images_edit(query: query) { result in
                switch result {
                case let .success(success):
                    return continuation.resume(returning: success)
                case let .failure(failure):
                    return continuation.resume(throwing: failure)
                }
            }
        }
    }

    func images_create_variation(
        query: ImageCreateVariationParams
    ) async throws -> ImagesResponse {
        try await withCheckedThrowingContinuation { continuation in
            images_create_variation(query: query) { result in
                switch result {
                case let .success(success):
                    return continuation.resume(returning: success)
                case let .failure(failure):
                    return continuation.resume(throwing: failure)
                }
            }
        }
    }

    func embeddings_create(
        query: EmbeddingCreateParams
    ) async throws -> EmbeddingResponse {
        try await withCheckedThrowingContinuation { continuation in
            embeddings_create(query: query) { result in
                switch result {
                case let .success(success):
                    return continuation.resume(returning: success)
                case let .failure(failure):
                    return continuation.resume(throwing: failure)
                }
            }
        }
    }

    func chat_completions(
        query: ChatCompletionCreateParams
    ) async throws -> ChatCompletion {
        try await withCheckedThrowingContinuation { continuation in
            chat_completions(query: query) { result in
//                do {
//                    print("ChatCompletion", "SUCCESS", try result.get())
//                    print("ChatCompletion", "SUCCESS", try JSONEncoder.encode(try result.get()))
//                } catch {
//                    print("ChatCompletion", error.localizedDescription)
//                }
                switch result {
                case let .success(success):
                    return continuation.resume(returning: success)
                case let .failure(failure):
                    return continuation.resume(throwing: failure)
                }
            }
        }
    }

    func chat_with_streaming_response_completions(
        query: ChatCompletionCreateParams
    ) -> AsyncThrowingStream<ChatCompletionChunk, Error> {
        return AsyncThrowingStream { continuation in
            return chat_with_streaming_response_completions(query: query)  { result in
                continuation.yield(with: result)
            } completion: { error in
                continuation.finish(throwing: error)
            }
        }
    }

    func models_retreive(
        query: ModelCreateParams
    ) async throws -> Model {
        try await withCheckedThrowingContinuation { continuation in
            models_retreive(query: query) { result in
                switch result {
                case let .success(success):
                    return continuation.resume(returning: success)
                case let .failure(failure):
                    return continuation.resume(throwing: failure)
                }
            }
        }
    }

    func models_delete(
        query: ModelCreateParams
    ) async throws -> ModelDeleted {
        try await withCheckedThrowingContinuation { continuation in
            models_delete(query: query) { result in
                switch result {
                case let .success(success):
                    return continuation.resume(returning: success)
                case let .failure(failure):
                    return continuation.resume(throwing: failure)
                }
            }
        }
    }

    func models_list() async throws -> ModelsResponse {
        try await withCheckedThrowingContinuation { continuation in
            models_list() { result in
                switch result {
                case let .success(success):
                    return continuation.resume(returning: success)
                case let .failure(failure):
                    return continuation.resume(throwing: failure)
                }
            }
        }
    }

    func moderations_create(
        query: ModerationCreateParams
    ) async throws -> ModerationCreateResponse {
        try await withCheckedThrowingContinuation { continuation in
            moderations_create(query: query) { result in
                switch result {
                case let .success(success):
                    return continuation.resume(returning: success)
                case let .failure(failure):
                    return continuation.resume(throwing: failure)
                }
            }
        }
    }

    func audio_speech_create(
        query: SpeechCreateParams
    ) async throws -> Speech {
        try await withCheckedThrowingContinuation { continuation in
            audio_speech_create(query: query) { result in
                switch result {
                case let .success(success):
                    return continuation.resume(returning: success)
                case let .failure(failure):
                    return continuation.resume(throwing: failure)
                }
            }
        }
    }

    func audio_transcriptions_create(
        query: TranscriptionCreateParams
    ) async throws -> Transcription {
        try await withCheckedThrowingContinuation { continuation in
            audio_transcriptions_create(query: query) { result in
                switch result {
                case let .success(success):
                    return continuation.resume(returning: success)
                case let .failure(failure):
                    return continuation.resume(throwing: failure)
                }
            }
        }
    }

    func audio_translations_create(
        query: TranslationCreateParams
    ) async throws -> Translation {
        try await withCheckedThrowingContinuation { continuation in
            audio_translations_create(query: query) { result in
                switch result {
                case let .success(success):
                    return continuation.resume(returning: success)
                case let .failure(failure):
                    return continuation.resume(throwing: failure)
                }
            }
        }
    }
}
