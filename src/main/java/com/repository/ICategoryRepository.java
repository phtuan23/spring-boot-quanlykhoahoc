package com.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.models.CategoryCourse;

@Repository
public interface ICategoryRepository extends JpaRepository<CategoryCourse, Integer> {

	@Query("SELECT c FROM CategoryCourse c")
	public Page<CategoryCourse> getAll(Pageable pageable);
	
	@Query("SELECT c FROM CategoryCourse c WHERE c.name LIKE %?1%")
	public Page<CategoryCourse> search(String search, Pageable pageable);
}
