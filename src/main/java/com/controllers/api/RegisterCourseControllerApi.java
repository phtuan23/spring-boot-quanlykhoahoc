package com.controllers.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.models.RegisterCourse;
import com.repository.IRegisterCourseRepository;

@RestController
@RequestMapping("/api/register-course")
@CrossOrigin("http://localhost:3000")
public class RegisterCourseControllerApi {

	@Autowired
	private IRegisterCourseRepository registerCourseRepository;
	
	@SuppressWarnings("rawtypes")
	@PostMapping("/create")
	public ResponseEntity save(@RequestBody RegisterCourse registerCourse){
		try {
			RegisterCourse rc = registerCourseRepository.save(registerCourse);
			return ResponseEntity.ok(rc);
		} catch (Exception e) {
			return ResponseEntity.status(400).body("Đăng ký thất bại. Vui lòng thử lại");
		}
	}
}
