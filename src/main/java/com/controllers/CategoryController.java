package com.controllers;

import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
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

import com.models.CategoryCourse;
import com.repository.ICategoryRepository;
import com.upload.FilesStorageService;

@Controller
@RequestMapping("/category")
public class CategoryController {
	private final int PAGE_SIZE = 6;
	private final String URL_UPLOAD = "http://localhost:8080/uploads/";
	
	@Autowired
	private ICategoryRepository categoryRepository;
	
	@Autowired
	private FilesStorageService filesStorageService;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		sdf.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(sdf, true));
	}
	
	@GetMapping({"","/{page}"})
	public String index(Model model, @PathVariable(name = "page", required = false) Integer p) {
		Integer page = p != null ? p : 1;
		Pageable pageable = PageRequest.of(page - 1, PAGE_SIZE, Sort.by("id").descending());
		model.addAttribute("page",categoryRepository.getAll(pageable));
		model.addAttribute("p",page);
		return "category/index";
	}
	
	@GetMapping("/create")
	public String create(Model model) {
		model.addAttribute("category", new CategoryCourse());
		return "category/create";
	}
	
	@PostMapping("/create")
	public String save(@Valid @ModelAttribute("category") CategoryCourse c, BindingResult result, Model model, 
			@RequestParam("upload") MultipartFile multipartFile, 
			RedirectAttributes red) {
		
		if(multipartFile.getOriginalFilename() == null || 
				multipartFile.getOriginalFilename() == "" || 
				multipartFile.getOriginalFilename().isBlank() || 
				multipartFile.getOriginalFilename().isEmpty()) {
			model.addAttribute("err_image","Vui lòng chọn ảnh");
			return "category/create";
		}
		
		if (result.hasErrors()) {
			return "category/create";
		}
		
		if (filesStorageService.save(multipartFile)) {
			c.setImage(URL_UPLOAD + multipartFile.getOriginalFilename());
			try {
				CategoryCourse cc = categoryRepository.save(c); 
				if (cc != null) {
					red.addFlashAttribute("success","Thêm mới thành công");
					return "redirect:/category";
				}else {
					model.addAttribute("error","Thêm mới thất bại. Vui lòng thử lại");
					return "category/create";
				}
			} catch (Exception e) {
				e.printStackTrace();
				model.addAttribute("error","Tên danh mục đã tồn tại.");
				return "category/create";
			}
		}else {
			model.addAttribute("err_image","Upload thất bại. Vui lòng kiểm tra lại.");
			return "category/create"; 
		}
	}
	
	@GetMapping("/{id}/update")
	public String edit(Model model, @PathVariable("id") Integer id) {
		model.addAttribute("category",categoryRepository.getById(id));
		return "category/edit";
	}
	
	@PostMapping("/{id}/update")
	public String update(@Valid @ModelAttribute("category") CategoryCourse c, 
			BindingResult result, 
			Model model, 
			@RequestParam("upload") MultipartFile multipartFile, 
			@PathVariable("id") Integer id,
			HttpServletRequest request, 
			RedirectAttributes red) {
		
		CategoryCourse category = categoryRepository.getById(id);
		c.setImage(category.getImage());
		if (result.hasErrors()) {
			return "category/edit";
		}
		
		if (multipartFile.getOriginalFilename() != "" || !multipartFile.getOriginalFilename().isBlank() || !multipartFile.getOriginalFilename().isEmpty()) {
			c.setImage(URL_UPLOAD + multipartFile.getOriginalFilename());
			filesStorageService.save(multipartFile);
		}
		
		try {
			CategoryCourse cc = categoryRepository.save(c);
			if (cc != null) {
				red.addFlashAttribute("success","Cập nhật danh mục ID = " + c.getId() + " thành công");				
				return "redirect:/category";
			}else {
				model.addAttribute("error","Cập nhật thất bại. Vui lòng thử lại");
				return "category/edit";
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error","Tên danh mục hoặc tên đường dẫn đã tồn tại");
			return "category/edit";
		}
	}
	
	@GetMapping("/{id}/delete")
	@ResponseBody
	public int delete(@PathVariable("id") Integer id) {
		CategoryCourse c = categoryRepository.getById(id);
		if (c.getCourses().size() > 0) {
			return 400;
		}
		
		try {
			categoryRepository.delete(c);
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
		model.addAttribute("page", categoryRepository.search(search, pageable));
		model.addAttribute("p",page);
		return "category/index";
	}
}
