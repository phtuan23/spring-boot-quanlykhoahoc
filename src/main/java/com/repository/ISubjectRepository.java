package com.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.models.Subject;

@Repository
public interface ISubjectRepository extends JpaRepository<Subject, Integer> {
	
	@Query("SELECT s FROM Subject s")
	public Page<Subject> getSubjects(Pageable pageable);
	
	@Query("SELECT s FROM Subject s WHERE s.name LIKE %?1%")
	
	public Page<Subject> search(String search, Pageable pageable);
	
	@Query("SELECT s FROM Subject s WHERE s.id NOT IN (SELECT sc.subject.id FROM Score sc WHERE sc.student.classroom.id = ?1)")
	// select sc.subject.id from Score sc WHERE sc.student.classroom.id = ?1
	public List<Subject> getSubs(Integer classId);
	
	@Query("SELECT s FROM Subject s WHERE s.id IN (SELECT sc.subject.id FROM Score sc WHERE sc.student.classroom.id = ?1)")
	public List<Subject> getSubjectByClassId(Integer classId);
}
