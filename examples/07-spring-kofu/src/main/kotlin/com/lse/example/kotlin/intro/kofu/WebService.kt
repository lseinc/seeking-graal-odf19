package com.lse.example.kotlin.intro.kofu


import org.springframework.boot.WebApplicationType
import org.springframework.fu.kofu.application
import org.springframework.fu.kofu.webflux.webFlux
import org.springframework.http.MediaType
import org.springframework.web.reactive.function.server.ServerRequest
import org.springframework.web.reactive.function.server.ServerResponse
import org.springframework.web.reactive.function.server.ServerResponse.ok
import reactor.core.publisher.Mono
import java.time.Duration

/**
 * https://github.com/spring-projects/spring-fu/blob/master/kofu/README.adoc
 */
val app = application(WebApplicationType.REACTIVE) {
    beans {
        bean<SampleService>()
        bean<SampleHandler>()
    }
    webFlux {
        port = if (profiles.contains("test")) 8181 else 8080
        router {
            val handler = ref<SampleHandler>()
            GET("/", handler::hello)
        }
        router {
            val handler = ref<SampleHandler>()
            GET("/api", handler::json)
            PUT("/api", accept(MediaType.APPLICATION_JSON), handler::helloPost)
        }
        codecs {
            string()
            jackson()
            form()
        }
    }
}

data class Sample(val message: String)

class SampleService {
    fun generateMessage() = "Hello world!"
}

@Suppress("UNUSED_PARAMETER")
class SampleHandler(private val sampleService: SampleService) {
    fun hello(request: ServerRequest)=
            ok().bodyValue(sampleService.generateMessage())
    fun json(request: ServerRequest) =
            ok().bodyValue(Sample(sampleService.generateMessage()))
    fun helloPost(request: ServerRequest) : Mono<ServerResponse> {
        println("helloPost request=$request")
        val attributes = request.attributes()
        val inMonoSample : Mono<Sample> = request.bodyToMono(Sample::class.java)
        val inSample = inMonoSample.block() ?: Sample("")
        println("\nincomingSample=$inSample\n")
        return ok().bodyValue(inSample)
    }
}

fun main() {
    app.run()
}

