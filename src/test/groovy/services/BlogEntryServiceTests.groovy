package services

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test

class BlogEntryServiceTests {

	@Test
	public void initialTest() {
		Assertions.assertEquals(10, 2 *5, "This should be true")
	}
	
	@Test
	public void getAllBlogEntriesTest() {
		Assertions.assertEquals(10, 2 *5, "This should be true")
	}
	
	@Test
	public void addBlogEntryValid() {
		//TODO check for date creation
		Assertions.assertEquals(10, 2 *5, "This should be true")
	}
	
	@Test
	public void addBlogEntryMissingTitle() {
		//TODO check for date creation
		Assertions.assertEquals(10, 2 *5, "This should be true")
	}
	
	@Test
	public void addBlogEntryMissingBody() {
		//TODO check for date creation
		Assertions.assertEquals(10, 2 *5, "This should be true")
	}
}
