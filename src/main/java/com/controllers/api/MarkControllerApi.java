package com.controllers.api;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.models.Student;
import com.repository.IStudentReporitory;

@RestController
@RequestMapping("/api/mark")
@CrossOrigin("http://localhost:3000")
public class MarkControllerApi {
	@Autowired
	private IStudentReporitory studentReporitory;
	
	@GetMapping("/check-score/{studentCode}")
	public Student checkScore(@PathVariable("studentCode") String studentCode){
		return studentReporitory.checkScore(studentCode);
	}
}
