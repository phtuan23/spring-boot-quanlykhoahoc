package com.controllers;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping("/")
public class AppController {
	@GetMapping("")
	public String index() {
		return "index";
	}
	
	@GetMapping("/login")
	public String login(Model model, @RequestParam(name = "error", required = false) String error) {
		if(error != null && error.equalsIgnoreCase("failed")) {
			model.addAttribute("error", "Tài khoản hoặc mật khẩu không đúng");
		}
		if(error != null && error.equalsIgnoreCase("deny")) {
			model.addAttribute("error", "Không được phép truy cập");
		}
		return "login";
	}
}
