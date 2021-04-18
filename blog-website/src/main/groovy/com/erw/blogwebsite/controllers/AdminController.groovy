package com.erw.blogwebsite.controllers

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

import javax.servlet.http.HttpServletResponse

@RestController
class AdminController {

    @GetMapping(value="/")
    void redirectRootToSwagger(HttpServletResponse response) {
        response.sendRedirect("/swagger-ui.html")
    }
}
