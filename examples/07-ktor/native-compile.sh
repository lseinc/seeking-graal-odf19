set -x
CP=./build/fatjar/07-ktor-kraal.jar
native-image \
  --no-server \
  --no-fallback \
  --enable-http \
  -Dkotlinx.coroutines.debug \
  -H:EnableURLProtocols=http,jar \
  -H:+ReportExceptionStackTraces \
  -H:ReflectionConfigurationFiles=./graalvm-reflection.json  \
  -H:Name=07-ktor-native \
  -H:+TraceClassInitialization \
  --initialize-at-build-time=kotlin.coroutines.CoroutineContext \
  --allow-incomplete-classpath \
  --report-unsupported-elements-at-runtime \
  -Dsun.rmi.transport.tcp.maxConnectionThreads=0 \
  -cp $CP AppKt



##############
##############
#kotlin/coroutines/CoroutineContext
#kotlin/coroutines/CoroutineContext$plus$1;,

  #-DremoveUnusedAutoconfig=true \
  #-H:+JNI \
##  --initialize-at-build-time=org.slf4j.LoggerFactory \
##  --initialize-at-build-time=org.slf4j.impl.SimpleLogger \
##  --initialize-at-build-time=org.slf4j.impl.SimpleLoggerFactory \
##  --initialize-at-build-time=org.slf4j.impl.SimpleLoggerConfiguration \
##  --initialize-at-build-time=org.slf4j.impl.SimpleLoggerConfiguration\$1 \
##  --initialize-at-build-time=org.slf4j.impl.OutputChoice \
##  --initialize-at-build-time=org.slf4j.helpers.Util \
##  --initialize-at-build-time=org.slf4j.helpers.NOPLoggerFactory \
##  --initialize-at-build-time=org.slf4j.helpers.SubstituteLoggerFactory \
##  --initialize-at-build-time=org.slf4j.impl.StaticLoggerBinder   \
##  --initialize-at-run-time=io.netty.handler.ssl.ReferenceCountedOpenSslContext \
##  --initialize-at-run-time=io.netty.handler.ssl.JdkNpnApplicationProtocolNegotiator \
##  --initialize-at-run-time=io.netty.handler.ssl.JettyNpnSslEngine \
##  --initialize-at-run-time=io.netty.channel.epoll.EpollEventArray \
##  --initialize-at-run-time=io.netty.channel.epoll.Native \
##  --initialize-at-run-time=io.netty.channel.kqueue.Native \
##  --initialize-at-run-time=io.netty.channel.kqueue.KQueueEventArray \
##  --initialize-at-run-time=io.netty.handler.ssl.ReferenceCountedOpenSslEngine \
##  --initialize-at-run-time=io.netty.handler.ssl.ConscryptAlpnSslEngine \

  #-H:IncludeResourceBundles=javax.servlet.http.LocalStrings \
  #--initialize-at-build-time=org.eclipse.jdt,org.apache.el.parser.SimpleNode,javax.servlet.jsp.JspFactory,org.apache.jasper.servlet.JasperInitializer,org.apache.jasper.runtime.JspFactoryImpl \
