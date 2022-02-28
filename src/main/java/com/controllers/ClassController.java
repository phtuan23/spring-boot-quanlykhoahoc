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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.models.Classroom;
import com.repository.IClassRepository;

@Controller
@RequestMapping("/class")
public class ClassController {
	private final int PAGE_SIZE = 6;
	private final Sort sort = Sort.by("id").descending();
	
	@Autowired
	private IClassRepository classRepository;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		sdf.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(sdf, true));
	}
	
	@GetMapping({"","{page}"})
	public String index(Model model, 
			@PathVariable(name = "page", required = false) Integer p) {
		Integer page = p != null ? p : 1;
		Pageable pageable = PageRequest.of(page - 1, PAGE_SIZE, sort);
		model.addAttribute("page",classRepository.getClasses(pageable));
		model.addAttribute("p",page);
		return "classroom/index";
	}
	
	@GetMapping("/create")
	public String create(Model model) {
		model.addAttribute("class", new Classroom());
		return "classroom/create";
	}
	
	@PostMapping("/create")
	public String save(@Valid @ModelAttribute("class") Classroom c, 
			BindingResult result,
			RedirectAttributes red, Model model) {
		if (result.hasErrors()) {
			return "classroom/create";
		}
		
		try {
			Classroom cr = classRepository.save(c);
			if (cr != null) {
				red.addFlashAttribute("success","Thêm mới thành công!");
				return "redirect:/class";
			}else {
				model.addAttribute("error", "Thêm mới thất bại. Vui lòng thử lại.");
				return "classroom/create";
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "Tên lớp đã tồn tại.");
			return "classroom/create";
		}
	}
	
	@GetMapping("/{id}/update")
	public String edit(Model model, @PathVariable("id") Integer id) {
		model.addAttribute("class", classRepository.getById(id));
		return "classroom/edit";
	}
	
	@PostMapping("/{id}/update")
	public String update(@Valid @ModelAttribute("class") Classroom c, 
			BindingResult result,
			RedirectAttributes red, Model model,
			@PathVariable("id") Integer id) {
		if (result.hasErrors()) {
			return "classroom/create";
		}
		
		try {
			Classroom cr = classRepository.save(c);
			if (cr != null) {
				red.addFlashAttribute("success","Cập nhật thành công!");
				return "redirect:/class";
			}else {
				model.addAttribute("error", "Cập nhật thất bại. Vui lòng thử lại.");
				return "classroom/create";
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "Tên lớp đã tồn tại.");
			return "classroom/create";
		}
	}
	
	@GetMapping("/{id}/delete")
	@ResponseBody
	public int delete(@PathVariable("id") Integer id) {
		Classroom c = classRepository.getById(id);
		if (c.getStudents().size() > 0) {
			return 400;
		}
		
		try {
			classRepository.delete(c);
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
		Pageable pageable = PageRequest.of(page - 1, PAGE_SIZE, sort);
		model.addAttribute("page", classRepository.search(search, pageable));
		model.addAttribute("p",page);
		return "classroom/index";
	}
}
