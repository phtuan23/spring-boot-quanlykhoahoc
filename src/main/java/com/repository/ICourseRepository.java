package com.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.models.Course;

@Repository
public interface ICourseRepository extends JpaRepository<Course, Integer>{
	
	@Query("SELECT c FROM Course c")
	public Page<Course> getCourses(Pageable pageable);
	
	@Query("SELECT c FROM Course c WHERE c.name LIKE %?1%")
	public Page<Course> search(String search, Pageable pageable);
	
	@Query("SELECT c FROM Course c WHERE c.category.id = ?1")
	public Page<Course> getByCate(Integer catId, Pageable pageable);
	
	@Query("SELECT c FROM Course c WHERE c.slug = ?1")
	public Course getBySlug(String slug);
	
	@Query("SELECT c FROM Course c WHERE c.category.slug = ?1")
	public List<Course> getByCateSlug(String slug);
}
