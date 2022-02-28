package com.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.models.RegisterCourse;
import com.repository.IRegisterCourseRepository;

@Controller
@RequestMapping("/register-course")
public class RegisterCourseController {
	private final int PAGE_SIZE = 6;
	@Autowired
	private IRegisterCourseRepository registerCourseRepository;
	
	@GetMapping("")
	public String index(Model model, @RequestParam(name = "page", defaultValue = "1") Integer page) {
		Pageable pageable = PageRequest.of(page - 1, PAGE_SIZE);
		
		model.addAttribute("page", registerCourseRepository.getListRegisterCourse(pageable));
		return "register-course/index";
	}
	
	@GetMapping("/update/{id}/{status}")
	@ResponseBody
	public int updateStatus(@PathVariable("id") Integer id, @PathVariable("status") int status) {
		RegisterCourse rc = registerCourseRepository.getById(id);
		if (status != 3) {
			rc.setStatus(status);
			registerCourseRepository.save(rc);
		}
		return 200;
	}
	
	@GetMapping("/search/{search}")
	public String search(Model model, @PathVariable("search") String search,
			@RequestParam(name = "page", required = false, defaultValue = "1") Integer page) {
		Pageable pageable = PageRequest.of(page - 1, PAGE_SIZE);
		model.addAttribute("page", registerCourseRepository.search(search, pageable));
		model.addAttribute("p", page);
		model.addAttribute("search", search);
		return "register-course/index";
	}
}
