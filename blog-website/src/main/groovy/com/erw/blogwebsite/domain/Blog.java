package com.erw.blogwebsite.domain;

import groovy.transform.EqualsAndHashCode;
import groovy.transform.ToString;
import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Data
@Entity
@Table(name="blogs")
@EqualsAndHashCode(includes="blogId")
@ToString(includeNames=true,includePackage = false)
class Blog implements Serializable {

    @Id
    @Column(name="id")
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    Long blogId;

    @Column(name = "title")
    String blogTitle;

    @Column(name="blog_body")
    String blogBody;

    @Column(name="date_created")
    Date dateCreated;
}