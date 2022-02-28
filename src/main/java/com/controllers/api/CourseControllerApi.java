package com.controllers.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.models.Course;
import com.repository.ICourseRepository;

@RestController
@RequestMapping("/api/course")
@CrossOrigin("http://localhost:3000")
public class CourseControllerApi {
	@Autowired
	private ICourseRepository courseRepository;
	
	@GetMapping("")
	public List<Course> getAll(){
		return courseRepository.findAll();
	}
	
	@GetMapping("/{slug}")
	public Course getBySlug(@PathVariable("slug") String slug) {
		return courseRepository.getBySlug(slug);
	}
	
	@GetMapping("/c/{slug}")
	public List<Course> getByCatSlug(@PathVariable("slug") String slug){
		return courseRepository.getByCateSlug(slug);
	}
}
