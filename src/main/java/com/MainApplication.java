package com;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;


@SpringBootApplication(scanBasePackages = "com")
@ComponentScan("com")
@EnableJpaRepositories("com.repository")
@EnableAutoConfiguration
public class MainApplication{
	public static void main(String[] args) {
		SpringApplication.run(MainApplication.class, args);
	}
}
