import com.fasterxml.jackson.databind.SerializationFeature
import io.ktor.application.call
import io.ktor.application.install
import io.ktor.features.*
import io.ktor.http.ContentType
import io.ktor.http.HttpStatusCode
import io.ktor.http.content.defaultResource
import io.ktor.http.content.resource
import io.ktor.http.content.static
import io.ktor.jackson.jackson
import io.ktor.response.respond
import io.ktor.response.respondRedirect
import io.ktor.response.respondText
import io.ktor.routing.Routing
import io.ktor.routing.get
import io.ktor.routing.head
import io.ktor.routing.route
import io.ktor.server.engine.applicationEngineEnvironment
import io.ktor.server.engine.connector
import io.ktor.server.engine.embeddedServer
import io.ktor.server.cio.CIO
import kotlinx.html.*
import kotlinx.html.stream.appendHTML
import java.io.StringWriter
import java.lang.Compiler.enable
import java.net.Inet4Address
import java.text.DateFormat
import java.time.ZonedDateTime
import java.time.format.DateTimeFormatter
import java.time.temporal.ChronoUnit
import java.util.*

val startDateTime = ZonedDateTime.now()

val env = applicationEngineEnvironment {
    connector {
        host = "0.0.0.0"
        port = 8080
    }
    module {
        install(ContentNegotiation) {
            jackson {
                enable(SerializationFeature.INDENT_OUTPUT) // Pretty Prints the JSON
                dateFormat = DateFormat.getDateInstance()
            }
        }
        install(DefaultHeaders)
        install(AutoHeadResponse)
        install(CallLogging)
        install(StatusPages)
        install(Routing) {
            route("/application") {
                head("/ready") {
                    call.respondText(ready(), ContentType.Text.Html)
                }
                get("/ready") {
                    call.respondText(ready(), ContentType.Text.Html)
                }
                get("/health") {
                    call.respondText(health(), ContentType.Text.Html, fetchHealthStatusCode())
                }
            }
            route("/api") {
                get("/hello") {
                    call.respond(Message("Hello World!"))
                }
            }
            get("/") {
                call.respondRedirect("/application/health")
            }
            static {
                defaultResource("/", "static")
            }
        }
    }
}

fun uptime() = String.format("%.5f day(s)", ChronoUnit.SECONDS.between(startDateTime, ZonedDateTime.now()) / 86400.0)

fun ready(): String = "Application is UP"

fun isHealthy(): Boolean = true

fun fetchHealthStatusCode(): HttpStatusCode = if (isHealthy()) {
    HttpStatusCode.OK
} else {
    HttpStatusCode.ServiceUnavailable
}

fun fetchHealthStatus(): String = if (isHealthy()) {
    "Ready"
} else {
    "Not Ready"
}

fun health(): String =
        StringWriter().appendHTML().html {
            head {
                title { +"Application Health" }
            }
            body {
                val megabyte = 1024.0 * 1024.0
                val runtime = Runtime.getRuntime()
                p { +"Application Health Report: ${fetchHealthStatus()}" }
                br
                p { +"Hostname:  ${Inet4Address.getLocalHost().hostName}" }
                br
                p { +"Runtime.getRuntime().availableProcessors(): ${runtime.availableProcessors()}" }
                p { +"Runtime.getRuntime().freeMemory(): ${String.format("%.3f MB", runtime.freeMemory() / megabyte)}" }
                p { +"Runtime.getRuntime().totalMemory(): ${String.format("%.3f MB", runtime.totalMemory() / megabyte)}" }
                p { +"Runtime.getRuntime().maxMemory(): ${String.format("%.3f MB", runtime.maxMemory() / megabyte)}" }
                br
                p { +"uptime: ${uptime()}" }
                p { +"as-of:  ${ZonedDateTime.now()}" }
            }
        }.toString()


fun main(args: Array<String>) {
    //embeddedServer(Jetty, env).start(true)
    //embeddedServer(Netty, env).start(true)
    embeddedServer(CIO, env).start(true)
}

data class Message(
        val message: String,
        val timestamp: String =
            DateTimeFormatter.ISO_OFFSET_DATE_TIME.format(ZonedDateTime.now())
)
