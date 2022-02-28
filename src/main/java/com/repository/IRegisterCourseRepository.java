package com.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.models.RegisterCourse;

@Repository
public interface IRegisterCourseRepository extends JpaRepository<RegisterCourse, Integer> {
	
	@Query("SELECT rc FROM RegisterCourse rc ORDER BY rc.id DESC")
	public Page<RegisterCourse> getListRegisterCourse(Pageable pageable);
	
	@Query("SELECT rc FROM RegisterCourse rc WHERE rc.name LIKE %?1% OR rc.email LIKE %?1% OR rc.phone LIKE %?1% OR rc.course.name LIKE %?1% ORDER BY rc.id DESC")
	public Page<RegisterCourse> search(String search, Pageable pageable);
}
