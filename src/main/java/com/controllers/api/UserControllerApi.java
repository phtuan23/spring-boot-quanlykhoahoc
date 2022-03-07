package com.controllers.api;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.models.Role;
import com.models.UserRole;
import com.models.Users;
import com.repository.IRoleRepository;
import com.repository.IUserRepository;
import com.repository.IUserRoleRepository;
import com.upload.FilesStorageService;

@RestController
@RequestMapping("/api/users")
@CrossOrigin("http://localhost:3000")
public class UserControllerApi {
	private final String URL_UPLOAD = "http://localhost:8080/uploads/";
	@Autowired
	private IUserRepository userRepository;
	@Autowired
	private IRoleRepository roleRepository;
	@Autowired
	private IUserRoleRepository userRoleRepository;
	@Autowired
	private FilesStorageService filesStorageService;
	
	@PostMapping("/save")
	public Object register(@RequestBody Users user) {
		Map<String,String> errors = new HashMap<>();
		for (var u : userRepository.findAll()) {
			if (u.getEmail().equalsIgnoreCase(user.getEmail())) {
				errors.put("email", "Email đã được sử dụng. Vui lòng thử email khác");
			}
			if (u.getUsername().equalsIgnoreCase(user.getUsername())) {
				errors.put("username", "Tên đăng nhập đã được sử dụng. Vui lòng thử lại.");
			}
		}
		
		if (errors.isEmpty()) {
			user.setEnabled(true);
			Users u = userRepository.save(user);
			Role r = roleRepository.getByName("ROLE_USER");
			userRoleRepository.save(new UserRole(new Role(r.getId()), new Users(u.getId())));
			return 200;
		}else {
			return errors;
		}
	}
	
	@PostMapping("/login")
	@ResponseBody
	public Object login(@RequestBody Users user) {
		Users u = userRepository.checkLogin(user.getUsername(), user.getPassword());
		return u;
	}
	
	@PostMapping(value="/uploadAvt")
	@ResponseBody
	public Object updateImage(@RequestParam("file") MultipartFile file, @RequestParam("id") Integer id) throws IOException {
		Users u = userRepository.getById(id);
		u.setImage(URL_UPLOAD + file.getOriginalFilename());
		filesStorageService.save(file);
		userRepository.save(u);
		return 200;
	}
	
	@GetMapping("/detail/{id}")
	@ResponseBody
	public Object getDetail(@PathVariable Integer id) {
		Users u = userRepository.getDetail(id);
		return u;
	}
}
