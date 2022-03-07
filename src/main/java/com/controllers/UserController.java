package com.controllers;


import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.models.Role;
import com.models.UserRole;
import com.models.Users;
import com.repository.IRoleRepository;
import com.repository.IUserRepository;
import com.repository.IUserRoleRepository;

@Controller
@RequestMapping("/users")
public class UserController {
	private final int PAGE_SIZE = 6;
	@Autowired
	private IUserRepository userRepository;
	@Autowired
	private IRoleRepository roleRepository;
	@Autowired
	private IUserRoleRepository userRoleRepository;
	
	@GetMapping("")
	public String index(Model model, @RequestParam(name = "page", defaultValue = "1") Integer page) {
		Pageable pageable = PageRequest.of(page - 1, PAGE_SIZE, Sort.by("id").descending());
		model.addAttribute("page", userRepository.getUsers(pageable));
		model.addAttribute("p", page);
		return "users/index";
	}
	
	@GetMapping("/create")
	public String create(Model model) {
		model.addAttribute("user",new Users());
		model.addAttribute("roles", roleRepository.findAll());
		return "users/create";
	}
	
	@PostMapping("/create")
	public String save(@Valid @ModelAttribute("user") Users user, 
			BindingResult result, Model model,
			@RequestParam("roleId") Integer roleId,
			RedirectAttributes red) {
		boolean hasErr = false;
		if (result.hasErrors()) {
			model.addAttribute("roles", roleRepository.findAll());
			return "users/create"; 
		}else {
			for (Users u : userRepository.findAll()) {
				if (user.getEmail().equalsIgnoreCase(u.getEmail())) {
					model.addAttribute("err_email","Email đã tồn tại. Hãy sử dụng email khác");
					hasErr = true;
					break;
				}
				if (user.getUsername().equalsIgnoreCase(u.getUsername())) {
					model.addAttribute("err_username", "Tên đăng nhập đã tồn tại. Hãy sử dụng tên đăng nhập khác");
					hasErr = true;
					break;
				}
			}
			
			if (hasErr == false) {
				user.setEnabled(true);
				Users u = userRepository.save(user);
				userRoleRepository.save(new UserRole(new Role(roleId), new Users(u.getId())));
				red.addFlashAttribute("success", "Thêm mới thành công");
				return "redirect:/users";
			}else {
				model.addAttribute("failed", "Dữ liệu chưa hợp lệ");
				model.addAttribute("roles", roleRepository.findAll());
				return "users/create"; 
			}
		}
	}
	
	@GetMapping("/{id}/update")
	public String edit(@PathVariable("id") Integer id, Model model) {
		model.addAttribute("user", userRepository.getById(id));
		model.addAttribute("roles", roleRepository.findAll());
		return "users/edit";
	}
	
	@PostMapping("/{id}/update")
	public String update(@Valid @ModelAttribute("user") Users user, 
			BindingResult result, Model model,
			@RequestParam("roleId") Integer roleId,
			RedirectAttributes red,
			@PathVariable("id") Integer id) {
		boolean hasErr = false;
		if (result.hasErrors()) {
			model.addAttribute("roles", roleRepository.findAll());
			return "users/create"; 
		}else {
			for (Users u : userRepository.findAll()) {
				if (user.getEmail().equalsIgnoreCase(u.getEmail()) && u.getId() != id) {
					model.addAttribute("err_email","Email đã tồn tại. Hãy sử dụng email khác");
					hasErr = true;
					break;
				}
				if (user.getUsername().equalsIgnoreCase(u.getUsername()) && u.getId() != id) {
					model.addAttribute("err_username", "Tên đăng nhập đã tồn tại. Hãy sử dụng tên đăng nhập khác");
					hasErr = true;
					break;
				}
			}
			
			if (hasErr == false) {
				user.setEnabled(true);
				userRepository.save(user);
				UserRole ur = userRoleRepository.getByIdUser(id);
				ur.setRole(new Role(roleId));
				userRoleRepository.save(ur);
				red.addFlashAttribute("success", "Cập nhật thành công");
				return "redirect:/users";
			}else {
				model.addAttribute("failed", "Dữ liệu chưa hợp lệ");
				model.addAttribute("roles", roleRepository.findAll());
				return "users/create"; 
			}
		}
	}
	
	@GetMapping("/search/{search}")
	public String search(@PathVariable("search") String search,
			@RequestParam(name = "page", defaultValue = "1") Integer page, Model model) {
		Pageable pageable = PageRequest.of(page - 1, PAGE_SIZE, Sort.by("id").descending());
		if (!search.equalsIgnoreCase("")) {
			model.addAttribute("search", search);
			model.addAttribute("page", userRepository.search(search, pageable));			
		}else {
			model.addAttribute("page", userRepository.getUsers(pageable));
		}
		return "users/index";
	}
}
