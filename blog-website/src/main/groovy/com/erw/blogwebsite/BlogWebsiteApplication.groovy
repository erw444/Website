package com.erw.blogwebsite

import org.springframework.boot.SpringApplication
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.cloud.netflix.eureka.EnableEurekaClient

@SpringBootApplication
class BlogWebsiteApplication {

	static void main(String[] args) {
		SpringApplication.run(BlogWebsiteApplication, args)
	}

}
