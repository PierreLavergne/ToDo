package com.middleware.api.javaapi.controller;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@Configuration
@EnableJpaRepositories(basePackages = "com.middleware.api.javaapi")
public class TodoRepositoryConfig {

}
