package com.controllers;

import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.data.domain.Page;
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

import com.models.Student;
import com.repository.IClassRepository;
import com.repository.IStudentReporitory;

@Controller
@RequestMapping("/student")
public class StudentController {
	private final int PAGE_SIZE = 6;
	private Sort sort = Sort.by("id").descending();
	
	@Autowired
	private IClassRepository classRepository;
	@Autowired
	private IStudentReporitory studentReporitory;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		sdf.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(sdf, true));
	}
	
	@GetMapping("")
	public String index(Model model, 
			@RequestParam(name = "classId", required = false) Integer classId,
			@RequestParam(name = "page", defaultValue = "1", required = false) Integer p){
		
		Pageable pageable = PageRequest.of(p - 1, PAGE_SIZE, sort);
		if (classId != null) {
			Page<Student> page = studentReporitory.getByClass(classId, pageable);
			model.addAttribute("page", page);
			model.addAttribute("classId", classId);
		}
		model.addAttribute("p", p);
		model.addAttribute("classes", classRepository.findAll());
		return "student/index";
	}
	
	@GetMapping("/create")
	public String create(Model model) {
		model.addAttribute("student", new Student());
		model.addAttribute("classes", classRepository.findAll());
		return "student/create";
	}
	
	@PostMapping("/create")
	public String save(@Valid @ModelAttribute("student") Student s, 
			BindingResult result,
			Model model,
			RedirectAttributes red) {
		model.addAttribute("classes", classRepository.findAll());
		if (result.hasErrors()) {
			return "student/create";
		}
		
		try {
			Student std = studentReporitory.save(s);
			if(std != null) {
				red.addFlashAttribute("success", "Thêm mới thành công");
				return "redirect:/student";
			}
			model.addAttribute("error", "Thêm mới thất bại. Vui lòng thử lại");
			return "student/create";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "Mã sinh viên đã tồn tại");
			return "student/create";
		}
	}
	
	@GetMapping("/{id}/update")
	public String edit(@PathVariable("id") Integer id, Model model) {
		model.addAttribute("student", studentReporitory.getById(id));
		model.addAttribute("classes", classRepository.findAll());
		return "student/edit";
	}
	
	@PostMapping("/{id}/update")
	public String update(@Valid @ModelAttribute("student") Student s, 
			BindingResult result,
			Model model,
			RedirectAttributes red) {
		model.addAttribute("classes", classRepository.findAll());
		if (result.hasErrors()) {
			return "student/create";
		}
		
		try {
			Student std = studentReporitory.save(s);
			if(std != null) {
				red.addFlashAttribute("success", "Cập nhật thành công");
				return "redirect:/student";
			}
			model.addAttribute("error", "Cập nhật thất bại. Vui lòng thử lại");
			return "student/create";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "Mã sinh viên đã tồn tại");
			return "student/create";
		}
	}
	
	@GetMapping("/search/{search}")
	public String search(Model model, @PathVariable("search") String search,
			@RequestParam(name = "page", required = false, defaultValue = "1") Integer page) {
		Pageable pageable = PageRequest.of(page - 1, PAGE_SIZE, sort);
		model.addAttribute("page", studentReporitory.search(search, pageable));
		model.addAttribute("p", page);
		model.addAttribute("classes", classRepository.findAll());
		model.addAttribute("search", search);
		return "student/index";
	}
	
	@GetMapping("/{id}/delete")
	@ResponseBody
	public int delete(@PathVariable("id") Integer id) {
		Student s = studentReporitory.getById(id);
		try {
			studentReporitory.delete(s);
		} catch (Exception e) {
			e.printStackTrace();
			return 400;
		}
		return 200;
	}
}
