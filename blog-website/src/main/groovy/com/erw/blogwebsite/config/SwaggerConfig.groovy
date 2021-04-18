import com.erw.blogwebsite.BlogWebsiteApplication
import org.apache.http.HttpHeaders
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer
import springfox.documentation.builders.ApiInfoBuilder
import springfox.documentation.builders.ParameterBuilder
import springfox.documentation.builders.PathSelectors
import springfox.documentation.builders.RequestHandlerSelectors
import springfox.documentation.schema.ModelRef
import springfox.documentation.service.ApiInfo
import springfox.documentation.spi.DocumentationType
import springfox.documentation.spring.web.plugins.Docket
import springfox.documentation.service.Parameter

@Configuration
class SwaggerConfig implements WebMvcConfigurer{

    @Bean
    Docket api() {
        return new Docket(DocumentationType.SWAGGER_2)
                .apiInfo(apiInfo())
                //.globalOperationParameters(getGloablParameters())
                .select()
                .apis(RequestHandlerSelectors.basePackage(BlogWebsiteApplication.class.getPackage().getName()))
                .paths(PathSelectors.any())
                .build()
    }

    private ApiInfo apiInfo() {
        return new ApiInfoBuilder()
                .title("blog-backend")
                .description("Backend service for blog functionality for website")
                .version("1")
                .build()
    }

    private List<Parameter> getGlobalParameters() {
        final List<Parameter> parameters = new ArrayList<>()

        //to require tokens in the header of requests
        parameters.add(new ParameterBuilder()
                    .name(HttpHeaders.AUTHORIZATION)
                    .description("Add an authorization token for security.")
                    .modelRef(new ModelRef("string"))
                    .parameterType("header")
                    .required(true)
                    .scalarExample("Bearer ")
                    .build())

        return parameters
    }

    @Override
    void addResourceHandlers(ResourceHandlerRegistry registry){
        registry.addResourceHandler("swagger-ui.html")
                .addResourceLocations("classpath:/META-INF/resources/")

        registry.addResourceHandler("/webjars/**")
                .addResourceLocations("classpath:/META-INF/resources/webjars/")
    }




}