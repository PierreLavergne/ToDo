package com.middleware.api.javaapi;

import io.github.cdimascio.dotenv.Dotenv;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication(exclude = { DataSourceAutoConfiguration.class })
@EnableJpaRepositories
@ComponentScan("com.middleware.api.javaapi.*")
@EntityScan("com.middleware.api.javaapi.*")
public class JavaApiApplication {

	public static void main(String[] args) {
		Dotenv dotenv = Dotenv.load();

		// Utilisez les variables d'environnement dans votre application
		System.setProperty("POSTGRES_PORT", dotenv.get("POSTGRES_PORT"));
		System.setProperty("POSTGRES_DB", dotenv.get("POSTGRES_DB"));
		System.setProperty("POSTGRES_USER", dotenv.get("POSTGRES_USER"));
		System.setProperty("POSTGRES_PASSWORD", dotenv.get("POSTGRES_PASSWORD"));

		SpringApplication.run(JavaApiApplication.class, args);
	}

}
