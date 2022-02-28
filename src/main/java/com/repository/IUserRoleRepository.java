package com.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.models.UserRole;

@Repository
public interface IUserRoleRepository extends JpaRepository<UserRole, Integer>{
	
	@Query("SELECT ur FROM UserRole ur WHERE ur.user.username = ?1 AND ur.user.password = ?2")
	public UserRole checkLogin(String username, String password);
}
