package com.erw.blogwebsite.service

import org.springframework.stereotype.Service
import com.erw.blogwebsite.domain.Blog
import com.erw.blogwebsite.domain.BlogRepo
import javax.inject.Inject

@Service
class BlogEntryService {
	
	@Inject
	private BlogRepo blogRepo
	
	def addBlogEntry(Blog blog) {
		if(blog.blogTitle && blog.blogBody) {
			blog.setDateCreated(new Date())
			blogRepo.save(blog)
		} else {
			throw new Exception("Empty Title or Body.")
		}
	}
	
	def getAllBlogEntries() {
		List<Blog> blogs = blogRepo.findAll();
		return blogs
	}
}
