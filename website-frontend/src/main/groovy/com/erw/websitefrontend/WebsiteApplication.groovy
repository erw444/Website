package com.erw.blogwebsite

import org.springframework.boot.SpringApplication
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.cloud.client.discovery.EnableDiscoveryClient
import org.springframework.cloud.netflix.eureka.EnableEurekaClient
import org.springframework.cloud.netflix.ribbon.RibbonClient;
//import org.springframework.cloud.netflix.zuul.EnableZuulProxy

//@EnableZuulProxy
@SpringBootApplication
@EnableEurekaClient
@EnableDiscoveryClient
@RibbonClient(name = "blog-website")
class WebsiteApplication {

	static void main(String[] args) {
		SpringApplication.run(WebsiteApplication, args)
	}

}
