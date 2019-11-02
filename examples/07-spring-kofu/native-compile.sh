CP=./build/libs/07-spring-kofu.jar
native-image \
  --no-server \
  --initialize-at-build-time=org.eclipse.jdt,org.apache.el.parser.SimpleNode,javax.servlet.jsp.JspFactory,org.apache.jasper.servlet.JasperInitializer,org.apache.jasper.runtime.JspFactoryImpl \
  -H:+JNI \
  -H:EnableURLProtocols=http,https,jar \
  -H:ReflectionConfigurationFiles=./graalvm-reflection.json  \
  --enable-https \
  -H:+TraceClassInitialization \
  -H:IncludeResourceBundles=javax.servlet.http.LocalStrings \
  -H:Name=spring-kofu-native \
  -H:+ReportExceptionStackTraces \
  --no-fallback \
  --allow-incomplete-classpath \
  --report-unsupported-elements-at-runtime \
  -Dsun.rmi.transport.tcp.maxConnectionThreads=0 \
  -DremoveUnusedAutoconfig=true \
  -cp $CP  org.springframework.boot.loader.JarLauncher

