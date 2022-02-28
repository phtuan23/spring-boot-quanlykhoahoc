package com.repository;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.models.Classroom;

@Repository
public interface IClassRepository extends JpaRepository<Classroom, Integer> {

	@Query("SELECT c FROM Classroom c")
	public Page<Classroom> getClasses(Pageable pageable);
	
	@Query("SELECT c FROM Classroom c WHERE c.name LIKE %?1%")
	public Page<Classroom> search(String search, Pageable pageable);
}
