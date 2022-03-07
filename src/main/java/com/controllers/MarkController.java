package com.controllers;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.models.Score;
import com.models.Student;
import com.models.Subject;
import com.repository.IClassRepository;
import com.repository.IMarkRepository;
import com.repository.IStudentReporitory;
import com.repository.ISubjectRepository;

@Controller
@RequestMapping("/mark")
public class MarkController {
	private final int PAGE_SIZE = 6;
	private Sort sort = Sort.by("id").descending();
	
	@Autowired
	private IMarkRepository markRepository;
	@Autowired
	private IStudentReporitory studentReporitory;
	@Autowired
	private IClassRepository classRepository;
	@Autowired
	private ISubjectRepository subjectRepository;
	
	@GetMapping({""})
	public String index(Model model, 
			@RequestParam(name = "page", required = false, defaultValue = "1") Integer page,
			@RequestParam(name = "classId", required = false) Integer classId,
			@RequestParam(name = "subjectId", required = false) Integer subjectId) {
		Pageable pageable = PageRequest.of(page - 1, PAGE_SIZE, sort);
		model.addAttribute("page", markRepository.getMarks(pageable));
		
		if (classId != null) {
			model.addAttribute("page", markRepository.getByClassId(classId, pageable));
			model.addAttribute("classId", classId);
			model.addAttribute("subjects", subjectRepository.getSubjectByClassId(classId));
			if (subjectId != null) {
				model.addAttribute("page", markRepository.getMarkBySubIdClassId(subjectId, classId, pageable));
				model.addAttribute("subjectId", subjectId);
			}
		}
		
		model.addAttribute("classes", classRepository.findAll());
		model.addAttribute("p", page);
		return "mark/index";
	}
	
	@GetMapping("/create")
	public String create(Model model, 
			@RequestParam(name = "classId", required = false) Integer classId,
			@RequestParam(name = "subjectId", required = false) Integer subjectId) {
		model.addAttribute("classes", classRepository.findAll());
		model.addAttribute("score", new Score());
		if (classId != null) {
			model.addAttribute("students", studentReporitory.studentByClassId(classId));
			model.addAttribute("classId", classId);
			model.addAttribute("subjects", subjectRepository.getSubs(classId));
			if (subjectId != null) {
				Subject s = subjectRepository.getById(subjectId);
				model.addAttribute("subject", s);
			}
		}
		return "mark/create";
	}
	
	@PostMapping("/create")
	@ResponseBody
	public Map<Object, Object> save(Model model,
			@RequestParam(name = "classId", required = false) Integer classId,
			@RequestParam(name = "subjectId", required = false) Integer subjectId,
			@RequestParam(name = "studentId[]") Integer studentId[],
			@RequestParam(name = "score[]") String scores[]) {
		Map<Object, Object> mapErr = new HashMap<>();
		Map<Object, Object> mapSucc = new HashMap<>();
		List<Score> listScores = new ArrayList<>();
		List<Integer> stdIds = Arrays.asList(studentId);
		List<String> marks = Arrays.asList(scores);
		
		List<Float> listMarks = new ArrayList<>();
		
		for (int i = 0; i < stdIds.size(); i++) {
			Student s = studentReporitory.getById(stdIds.get(i));
			try {
				if(marks.get(i) == "") {
					mapErr.put(s.getStudentCode(), "Vui lòng nhập điểm thi.");
				}else {
					Float _score = Float.parseFloat(marks.get(i));
					if (_score < 0 || _score > 20) {
						mapErr.put(s.getStudentCode(), "Điểm từ 0 - 20");
					}else {
						listMarks.add(_score);
					}
				}
			} catch (Exception e) {
				mapErr.put(s.getStudentCode(), "Điểm của sinh viên " + s.getStudentCode() + " - " + s.getName() + " không hợp lệ");
			}
		}
		
		for (int i = 0; i < listMarks.size(); i++) {
			listScores.add(new Score(new Student(stdIds.get(i)), new Subject(subjectId), listMarks.get(i)));
		}
		
//		save score
		if (mapErr.isEmpty()) {
			try {
				for (Score sc : listScores) {
					markRepository.save(sc);
				}
			} catch (Exception e) {
				mapErr.put("error", "Có lỗi. Vui lòng thử lại.");
			}
			mapSucc.put("success", "Thêm mới thành công");
			return mapSucc;
		}
		return mapErr;
	}
	
	@GetMapping("/update")
	@ResponseBody
	public int update(@RequestParam("studentId") Integer studentId, @RequestParam("subjectId") Integer subjectId, 
			@RequestParam("mark")  Float score) {
		if (score < 0 || score > 10) {
			return 400;
		}
		Score s = markRepository.getByStdIdAndSubId(studentId, subjectId);
		s.setScore(score);
		markRepository.save(s);
		return 200;
	}
	
	@GetMapping("/search/{search}")
	public String search(Model model, @PathVariable("search") String search,
			@RequestParam(name = "page", required = false, defaultValue = "1") Integer page) {
		Pageable pageable = PageRequest.of(page - 1, PAGE_SIZE, sort);
		model.addAttribute("page", markRepository.search(search, pageable));
		model.addAttribute("p", page);
		model.addAttribute("search", search);
		model.addAttribute("classes", classRepository.findAll());
		return "mark/index";
	}
}
