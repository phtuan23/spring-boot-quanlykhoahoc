package com.controllers.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.models.CategoryCourse;
import com.repository.ICategoryRepository;

@RestController
@RequestMapping("/api/c")
@CrossOrigin("http://localhost:3000")
public class CategoryCourseControllerApi {
	@Autowired
	private ICategoryRepository categoryRepository;
	
	@GetMapping("")
	public List<CategoryCourse> getAll(){
		return categoryRepository.findAll();
	}
}
