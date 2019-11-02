
### Build and run 
- `./gradlew bootRun` # to run on port 8080 (same as docker container exposed ports)
- `spring_profiles_active=test ./gradlew bootRun` # to run on port 8181 

### native image build
- # on mac: ` export SDKROOT=`xcrun --show-sdk-path`
- `native-image --no-fallback -jar ./build/libs/07-spring-kofu.jar com.lse.example.kotlin.intro.kofu.WebService `
