package com.controllers;

import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.models.Course;
import com.repository.ICategoryRepository;
import com.repository.ICourseRepository;
import com.upload.FilesStorageService;

@Controller
@RequestMapping("/course")
public class CourseController {
	private final int PAGE_SIZE = 4;
	private final String URL_UPLOAD = "http://localhost:8080/uploads/";
	
	@Autowired
	private ICourseRepository courseRepository;
	@Autowired
	private FilesStorageService filesStorageService;
	@Autowired
	private ICategoryRepository categoryRepository;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		sdf.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(sdf, true));
	}
	
	@GetMapping({""})
	public String index(Model model, 
			@RequestParam(name = "page", defaultValue = "1") Integer page) {
		Pageable pageable = PageRequest.of(page - 1, PAGE_SIZE, Sort.by("id").descending());
		model.addAttribute("page", courseRepository.getCourses(pageable));
		model.addAttribute("p", page);
		model.addAttribute("categories",categoryRepository.findAll());
		return "course/index";
	}
	
	@GetMapping("/create")
	public String create(Model model) {
		model.addAttribute("course", new Course());
		model.addAttribute("categories",categoryRepository.findAll());
		return "course/create";
	}
	
	@PostMapping("/create")
	public String save(
			@Valid @ModelAttribute("course") Course c, 
			BindingResult result,
			@RequestParam("upload") MultipartFile file,
			Model model,
			RedirectAttributes red) {
		
		if (file.getOriginalFilename() == "" || file.getOriginalFilename().isBlank() || file.getOriginalFilename().isEmpty() || file.getOriginalFilename() == null) {
			model.addAttribute("err_image","Vui lòng chọn ảnh");
		}
		
		if (result.hasErrors()) {
			model.addAttribute("categories",categoryRepository.findAll());
			return "course/create";
		}
		
		c.setImage(URL_UPLOAD + file.getOriginalFilename());
		if (filesStorageService.save(file)) {
			try {
				Course course = courseRepository.save(c);
				if (course != null) {
					red.addFlashAttribute("success","Thêm mới thành công");
					return "redirect:/course";
				}else {
					model.addAttribute("error","Thêm mới thất bại. Vui lòng thử lại.");
					return "course/create"; 
				}
			} catch (Exception e) {
				e.printStackTrace();
				model.addAttribute("error","Tên khoá học đã tồn tại.");
				return "course/create";
			}
		}else {
			model.addAttribute("err_image","Upload thất bại. Vui lòng kiểm tra lại.");
			return "course/create"; 
		}
	}
	
	@GetMapping("/{id}/update")
	public String edit(Model model, @PathVariable("id") Integer id) {
		Course c = courseRepository.getById(id);
		model.addAttribute("course",c);
		model.addAttribute("categories",categoryRepository.findAll());
		return "course/edit";
	}
	
	@PostMapping("/{id}/update")
	public String update(@Valid @ModelAttribute("course") Course c, 
			BindingResult result,
			Model model,
			@PathVariable("id") Integer id,
			@RequestParam("upload") MultipartFile file,
			RedirectAttributes red) {
		
		model.addAttribute("categories",categoryRepository.findAll());
		Course course = courseRepository.getById(id);
		
		if (file.getOriginalFilename() != "" || !file.getOriginalFilename().isBlank() || !file.getOriginalFilename().isEmpty()) {
			c.setImage(URL_UPLOAD + file.getOriginalFilename());
			filesStorageService.save(file);
		}else {
			System.out.println(course.getImage());
			c.setImage(course.getImage());
		}
		
		if (result.hasErrors()) {
			return "course/edit";
		}
		
		try {
			courseRepository.save(c);
			red.addFlashAttribute("success", "Cập nhật thành công");
			return "redirect:/course";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error","Tên Khoá học hoặc tên đường dẫn đã tồn tại");
			return "course/edit";
		}
	}
	
	@GetMapping("/{id}/delete")
	@ResponseBody
	public int delete(@PathVariable("id") Integer id) {
		Course c = courseRepository.getById(id);
		try {
			courseRepository.delete(c);
		} catch (Exception e) {
			e.printStackTrace();
			return 400;
		}
		return 200;
	}
	
	
	@GetMapping({"/search/{search}"})
	public String search(Model model, 
			@PathVariable("search") String search,
			@RequestParam(name = "page", defaultValue = "1") Integer page) {
		Pageable pageable = PageRequest.of(page - 1, PAGE_SIZE, Sort.by("id").descending());
		model.addAttribute("page", courseRepository.search(search, pageable));
		model.addAttribute("categories",categoryRepository.findAll());
		model.addAttribute("p",page);
		return "course/index";
	}
	
	@GetMapping({"/category/{category}"})
	public String getByCat(Model model,
			@PathVariable("category") Integer catId,
			@RequestParam(name = "page", defaultValue = "1") Integer page ) {
		Pageable pageable = PageRequest.of(page - 1, PAGE_SIZE, Sort.by("id").descending());
		model.addAttribute("categories",categoryRepository.findAll());
		model.addAttribute("page", courseRepository.getByCate(catId, pageable));
		model.addAttribute("p",page);
		return "course/index";
	}
}
