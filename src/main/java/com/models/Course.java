package com.models;

import java.sql.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;


@Entity
@Table(name = "course")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Course {
	@Id
	@Column(name = "id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@NotBlank(message = "{validate.course.name.req}")
	@Column(name = "name")
	private String name;
	
	@NotBlank(message = "{validate.course.slug.req}")
	@Column(name = "slug")
	private String slug;
	
	@Min(value = 5, message = "{validate.course.session.min}")
	@Column(name = "session")
	@NotNull(message = "{validate.course.session.req}")
	private Integer session;
	
	@Column(name = "image")
	private String image;
	
	@NotBlank(message = "{validate.course.description.req}")
	@Column(name = "description")
	private String description;
	
	@Min(value = 1, message = "{validate.course.price.min}")
	@NotNull(message = "{validate.course.price.req}")
	@Column(name = "price")
	private Float price;
	
	@Column(name = "status")
	private int status;
	
	@Column(name = "created")
	private Date created;
	
	@JsonIgnoreProperties("courses")
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name = "category_id", referencedColumnName = "id")
	private CategoryCourse category;
	
	@OneToMany(mappedBy = "course")
	private List<RegisterCourse> registerCourses;
	
	public Course() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSlug() {
		return slug;
	}

	public void setSlug(String slug) {
		this.slug = slug;
	}

	public Integer getSession() {
		return session;
	}

	public void setSession(Integer session) {
		this.session = session;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Float getPrice() {
		return price;
	}

	public void setPrice(Float price) {
		this.price = price;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Date getCreated() {
		return created;
	}

	public void setCreated(Date created) {
		this.created = created;
	}

	public CategoryCourse getCategory() {
		return category;
	}

	public void setCategory(CategoryCourse category) {
		this.category = category;
	}
}
