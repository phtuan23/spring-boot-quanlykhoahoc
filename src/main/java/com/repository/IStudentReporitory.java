package com.repository;


import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.models.Student;

@Repository
public interface IStudentReporitory extends JpaRepository<Student, Integer>{
	
	@Query("SELECT s FROM Student s")
	public Page<Student> getStudents(Pageable pageable);
	
	@Query("SELECT s FROM Student s WHERE s.classroom.id = ?1")
	public Page<Student> getByClass(Integer id, Pageable pageable);
	
	@Query("SELECT s FROM Student s WHERE s.name LIKE %?1% OR s.studentCode = ?1 OR s.email LIKE %?1% OR s.phone LIKE %?1%")
	public Page<Student> search(String search, Pageable pageable);
	
	@Query("SELECT s FROM Student s WHERE s.classroom.id = ?1")
	public List<Student> studentByClassId(Integer classId);
	
	@Query("SELECT s FROM Student s WHERE s.studentCode = ?1")
	public Student checkScore(String studentCode);
}
