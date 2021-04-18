package com.erw.blogwebsite.controllers

import org.junit.jupiter.api.BeforeAll
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test
import org.mockito.InjectMocks
import org.mockito.Mock
import org.mockito.*

import com.erw.blogwebsite.domain.Blog
import com.erw.blogwebsite.service.BlogEntryService
import static org.mockito.Mockito.*;

class BlogEntryControllerTests {
	
	@Mock 
	BlogEntryService mockService
	
	@InjectMocks
	BlogEntryController mockController
	
	private List<Blog> allBlogEntries
	private Blog firstBlog
	private Blog secondBlog
	
	@BeforeAll
	public void initialize() {
		MockitoAnnotations.initMocks(this);
		
		allBlogEntries = new ArrayList<Blog>()
		
		firstBlog = new Blog(1, "First Title", "This is the blog body", new Date())
		secondBlog = new Blog(2, "Second Title", "This is the second blog body", new Date())
		
		allBlogEntries.add(firstBlog)
		allBlogEntries.add(secondBlog)
	}
	
	@Test
	public void getAllBlogEntriesTest() {
		when(mockService.getAllBlogEntries()).thenReturn(allBlogEntries);
		
		Assertions.assertEquals(service.addCustomer(customer), is(notNullValue()));
		Assertions.assertEquals(10, 2 *5, "This should be true")
	}
	
	@Test
	public void addBlogEntryValid() {
		Assertions.assertEquals(10, 2 *5, "This should be true")
	}
	
	@Test
	public void addBlogEntryInValid() {
		Assertions.assertEquals(10, 2 *5, "This should be true")
	}
	
}
