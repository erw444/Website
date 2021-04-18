package com.erw.blogwebsite.controllers

import com.erw.blogwebsite.domain.Blog
import com.erw.blogwebsite.service.BlogEntryService
import javax.inject.Inject
import org.springframework.http.ResponseEntity
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.ResponseBody

@Controller
class BlogEntryController {
	@Inject BlogEntryService blogEntryService
	
	@PostMapping(value="/blog/new")
	@ResponseBody
	def addNewBlogEntry(@RequestBody Blog blog) {
		try {
			blogEntryService.addBlogEntry(blog)
		} catch(Exception e) {
			return new ResponseEntity(e.getMessage(), HttpStatus.NOT_ACCEPTABLE)
		}
	}
	
	@GetMapping(value="/blog/all")
	@ResponseBody
	def getAllBlogEntries() {
		blogEntryService.getAllBlogEntries();
	}
	
}
