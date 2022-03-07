package com.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.models.Role;

@Repository
public interface IRoleRepository extends JpaRepository<Role, Integer>{
	@Query("SELECT r FROM Role r WHERE r.name = ?1")
	public Role getByName(String name);
	
}
