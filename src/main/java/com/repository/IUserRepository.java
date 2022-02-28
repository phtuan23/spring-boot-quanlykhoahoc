package com.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.models.Users;

@Repository
public interface IUserRepository extends JpaRepository<Users, Integer>{
	@Query("SELECT u FROM Users u")
	public Page<Users> getUsers(Pageable pageable);
	
	
	@Query("SELECT u FROM Users u WHERE u.username = ?1 AND u.password = ?2")
	public Users checkLogin(String username, String password);
}
