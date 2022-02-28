package com.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.repository.IUserRepository;

@Controller
@RequestMapping("/users")
public class UserController {
	private final int PAGE_SIZE = 6;
	@Autowired
	private IUserRepository userRepository;
	
	@GetMapping("")
	public String index(Model model, @RequestParam(name = "page", defaultValue = "1") Integer page) {
		Pageable pageable = PageRequest.of(page - 1, PAGE_SIZE, Sort.by("id").descending());
		model.addAttribute("page",userRepository.getUsers(pageable));
		return "users/index";
	}
}
