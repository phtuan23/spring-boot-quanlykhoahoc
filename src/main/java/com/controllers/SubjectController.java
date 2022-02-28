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

import com.models.Subject;
import com.repository.ISubjectRepository;

@Controller
@RequestMapping("/subject")
public class SubjectController {
	private final int PAGE_SIZE = 6;
	private Sort sort = Sort.by("id").descending();
	
	@Autowired
	private ISubjectRepository subjectRepository;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		sdf.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(sdf, true));
	}
	
	@GetMapping({""})
	public String index(Model model, @RequestParam(name = "page", required = false, defaultValue = "1") Integer page) {
		Pageable pageable = PageRequest.of(page - 1, PAGE_SIZE, sort);
		
		model.addAttribute("p", page);
		model.addAttribute("page", subjectRepository.getSubjects(pageable));
		return "subject/index";
	}
	
	@GetMapping("/create")
	public String create(Model model) {
		model.addAttribute("subject", new Subject());
		return "subject/create";
	}
	
	@PostMapping("/create")
	public String save(@Valid @ModelAttribute("subject") Subject subject, 
			BindingResult result, Model model, RedirectAttributes red) {
		if (result.hasErrors()) {
			return "subject/create";
		}
		
		try {
			Subject s = subjectRepository.save(subject);
			if (s != null) {
				red.addFlashAttribute("success", "Thêm mới thành công");
				return "redirect:/subject";
			}
			model.addAttribute("error", "Thêm mới thất bại. Vui lòng thử lại.");
			return "subject/create";
		} catch (Exception e) {
			model.addAttribute("error", "Tên môn học đã tồn tại.");
			return "subject/create";
		}
	}
	
	@GetMapping("/{id}/update")
	public String edit(@PathVariable("id") Integer id, Model model) {
		model.addAttribute("subject", subjectRepository.getById(id));
		return "subject/edit";
	}
	
	@PostMapping("/{id}/update")
	public String update(@Valid @ModelAttribute("subject") Subject subject, 
			BindingResult result, Model model, RedirectAttributes red) {
		if (result.hasErrors()) {
			return "subject/create";
		}
		
		try {
			Subject s = subjectRepository.save(subject);
			if (s != null) {
				red.addFlashAttribute("success", "Cập nhật thành công");
				return "redirect:/subject";
			}
			model.addAttribute("error", "Cập nhật thất bại. Vui lòng thử lại.");
			return "subject/create";
		} catch (Exception e) {
			model.addAttribute("error", "Tên môn học đã tồn tại.");
			return "subject/create";
		}
	}
	
	@GetMapping("/search/{search}")
	public String search(Model model, @PathVariable("search") String search,
			@RequestParam(name = "page", required = false, defaultValue = "1") Integer page) {
		Pageable pageable = PageRequest.of(page - 1, PAGE_SIZE, sort);
		model.addAttribute("page", subjectRepository.search(search, pageable));
		model.addAttribute("p", page);
		model.addAttribute("search", search);
		return "subject/index";
	}
	
	@GetMapping("/{id}/delete")
	@ResponseBody
	public int delete(@PathVariable("id") Integer id) {
		Subject s = subjectRepository.getById(id);
		try {
			subjectRepository.delete(s);
		} catch (Exception e) {
			e.printStackTrace();
			return 400;
		}
		return 200;
	}
}
