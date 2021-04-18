package com.erw.blogwebsite

import org.springframework.boot.SpringApplication
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.cloud.netflix.eureka.EnableEurekaClient
import springfox.documentation.swagger2.annotations.EnableSwagger2

//TODO: Connect database to AWS RDS
//TODO: Fix up tests
@SpringBootApplication
@EnableSwagger2
class BlogWebsiteApplication {

	static void main(String[] args) {
		SpringApplication.run(BlogWebsiteApplication, args)
	}

}
