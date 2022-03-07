package com.repository;


import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.models.Score;

@Repository
public interface IMarkRepository extends JpaRepository<Score, Integer>{
	
	@Query("SELECT s FROM Score s")
	public Page<Score> getMarks(Pageable pageable);
	
	@Query("SELECT s FROM Score s WHERE s.subject.name LIKE %?1% OR s.student.studentCode LIKE %?1% OR s.student.name LIKE %?1%")
	public Page<Score> search(String search, Pageable pageable);
	
	@Query("SELECT s FROM Score s WHERE s.student.classroom.id = ?1")
	public Page<Score> getByClassId(Integer classId, Pageable pageable);
	
	@Query("SELECT s FROM Score s WHERE s.subject.id = ?1")
	public Page<Score> getBySubjectId(Integer subjectId, Pageable pageable);
	
	@Query("SELECT s FROM Score s WHERE s.subject.id = ?1 AND s.student.classroom.id = ?2")
	public Page<Score> getMarkBySubIdClassId(Integer subjectId, Integer classId, Pageable pageable);
	
	@Query("SELECT s FROM Score s WHERE s.student.studentCode = ?1")
	public List<Score> checkScore(String studentCode);
	
	@Query("SELECT s FROM Score s WHERE s.student.id = ?1 AND s.subject.id = ?2")
	public Score getByStdIdAndSubId(Integer studentId, Integer subjectId);
}
