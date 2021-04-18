package com.erw.blogwebsite.domain

import org.springframework.data.repository.CrudRepository

interface BlogRepo extends CrudRepository<Blog, Long> {

}
