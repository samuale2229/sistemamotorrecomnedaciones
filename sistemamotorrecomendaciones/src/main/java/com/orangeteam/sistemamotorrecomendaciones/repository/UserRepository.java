package com.orangeteam.sistemamotorrecomendaciones.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.orangeteam.sistemamotorrecomendaciones.model.User;


public interface UserRepository extends JpaRepository<User, Long> {
}